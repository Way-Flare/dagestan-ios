//
//  PlaceDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import SwiftUI

protocol IPlaceDetailViewModel: ObservableObject {
    var placeDetail: LoadingState<PlaceDetail> { get }
    var placeFeedbacks: LoadingState<PlaceFeedbackList> { get }
    var promocodes: LoadingState<[Promocode]> { get }
    var isVisibleSnackbar: Bool { get set }
    var isBackdropVisible: Bool { get set }
    var hasContactsData: Bool { get set }
    var formatter: TimeSuffixFormatter { get }
    var service: IPlacesService { get }
    var sharedUrl: URL? { get }
    var isAuthorized: Bool { get }
    /// Массив включающих всех юзеров кроме самого юзера
    var userFeedbacks: [PlaceFeedback] { get }

    func loadPlaceDetail()
    func loadPlaceFeedbacks()
    func loadPromocode()
}

final class PlaceDetailViewModel: IPlaceDetailViewModel {
    @Published var placeDetail: LoadingState<PlaceDetail> = .idle
    @Published var placeFeedbacks: LoadingState<PlaceFeedbackList> = .idle
    @Published var promocodes: LoadingState<[Promocode]> = .idle
    @Published var isVisibleSnackbar = false
    @Published var isBackdropVisible = false
    @Published var hasContactsData = false
    @Published var isFavorite: Bool
    @Published var favoriteState: LoadingState<Bool> = .idle
    @AppStorage("isAuthorized") var isAuthorized = false

    lazy var formatter = TimeSuffixFormatter(workTime: placeDetail.data?.workTime)

    private var isLoadingMoreCharacters = false
    let service: IPlacesService
    private var placeInfo: PlaceAnalyticEventInfo
    let sharedUrl: URL?

    var userFeedbacks: [PlaceFeedback] {
        guard let feedbacks = placeFeedbacks.data?.results, !feedbacks.isEmpty else {
            return []
        }
        if feedbacks.first!.user.username == UserDefaults.standard.string(forKey: "username") {
            return Array(feedbacks.dropFirst())
        }
        return feedbacks
    }

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    /// - Parameter placeInfo: Краткая информация о месте
    init(service: IPlacesService, placeInfo: PlaceAnalyticEventInfo, isFavorite: Bool) {
        self.service = service
        self.placeInfo = placeInfo
        self.isFavorite = isFavorite
        self.sharedUrl = URL(string: "https://dagestan-trails.ru/place/\(placeInfo.id)")
    }

    func loadPlaceDetail() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            self.placeDetail = .loading

            do {
                let place = try await service.getPlace(id: placeInfo.id)
                placeDetail = .loaded(place)
                hasContactsData = isContactsData(place: place)
                placeInfo = place.asAnalyticsData()
                Analytics.shared.report(event: PlaceAnalytics.loadedPlaceDetailInfo(place: placeInfo))
            } catch {
                placeDetail = .failed(error.localizedDescription)
                Analytics.shared.report(
                    event: PlaceAnalytics.failed(
                        place: placeInfo,
                        error: "Произошла ошибка при загрузке места: \(error.localizedDescription)"
                    )
                )
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    func loadPlaceFeedbacks() {
        placeFeedbacks = .loading

        Task {
            do {
                let parameters = PlaceFeedbackParametersDTO(id: placeInfo.id, pageSize: nil, pages: nil)
                let feedbacks = try await service.getPlaceFeedbacks(parameters: parameters)
                placeFeedbacks = .loaded(feedbacks)
            } catch {
                placeFeedbacks = .failed(error.localizedDescription)
                Analytics.shared.report(
                    event: PlaceAnalytics.failed(
                        place: placeInfo,
                        error: "Произошла ошибка при отзывов к месту: \(error.localizedDescription)"
                    )
                )
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    func loadPromocode() {
        promocodes = .loading

        Task {
            do {
                let loadedPromocodes = try await service.getPromocode(by: placeInfo.id)
                promocodes = .loaded(loadedPromocodes)
                Analytics.shared.report(event: PlaceAnalytics.loadedPromocode(place: placeInfo))
            } catch {
                promocodes = .failed(error.localizedDescription)
                Analytics.shared.report(
                    event: PlaceAnalytics.failed(
                        place: placeInfo,
                        error: "Произошла ошибка при загрузке промокода: \(error.localizedDescription)"
                    )
                )
            }
        }
    }

    private func isContactsData(place: PlaceDetail) -> Bool {
        guard let contacts = place.contacts.first else { return false }
        return contacts.phoneNumber != nil || contacts.site != nil || contacts.email != nil
    }

}
