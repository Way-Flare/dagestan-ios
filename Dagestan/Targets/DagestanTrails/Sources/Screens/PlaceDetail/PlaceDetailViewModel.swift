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
    @Published var isFavorite: Bool
    @Published var favoriteState: LoadingState<Bool> = .idle
    @AppStorage("isAuthorized") var isAuthorized = false

    lazy var formatter = TimeSuffixFormatter(workTime: placeDetail.data?.workTime)

    private var isLoadingMoreCharacters = false
    let service: IPlacesService
    private let placeId: Int
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
    /// - Parameter placeId: Id - для получения детальной информации о месте.
    init(service: IPlacesService, placeId: Int, isFavorite: Bool) {
        self.service = service
        self.placeId = placeId
        self.isFavorite = isFavorite
        self.sharedUrl = URL(string: "https://dagestan-trails.ru/place/\(placeId)")
    }

    func loadPlaceDetail() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            self.placeDetail = .loading

            do {
                let place = try await service.getPlace(id: placeId)
                placeDetail = .loaded(place)
            } catch {
                placeDetail = .failed(error.localizedDescription)
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    func loadPlaceFeedbacks() {
        placeFeedbacks = .loading

        Task {
            do {
                let parameters = PlaceFeedbackParametersDTO(id: placeId, pageSize: nil, pages: nil)
                let feedbacks = try await service.getPlaceFeedbacks(parameters: parameters)
                placeFeedbacks = .loaded(feedbacks)
            } catch {
                placeFeedbacks = .failed(error.localizedDescription)
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func loadPromocode() {
        promocodes = .loading
        
        Task {
            do {
                let loadedPromocodes = try await service.getPromocode(by: placeId)
                promocodes = .loaded(loadedPromocodes)
            } catch {
                promocodes = .failed(error.localizedDescription)
            }
        }
    }
}
