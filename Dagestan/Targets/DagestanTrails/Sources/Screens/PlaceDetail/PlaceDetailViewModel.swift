//
//  PlaceDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import Foundation
protocol IPlaceDetailViewModel: ObservableObject {
    var state: LoadingState<PlaceDetail> { get }
    var isVisibleSnackbar: Bool { get set }
    var isBackdropVisible: Bool { get set }
    var formatter: TimeSuffixFormatter { get }
    var service: IPlacesService { get }
    var sharedUrl: URL? { get }

    func loadPlaceDetail()
}

final class PlaceDetailViewModel: IPlaceDetailViewModel {
    @Published var state: LoadingState<PlaceDetail> = .idle
    @Published var isVisibleSnackbar = false
    @Published var isBackdropVisible = false
    @Published var isFavorite: Bool
    @Published var favoriteState: LoadingState<Bool> = .idle
    var sharedUrl: URL?

    lazy var formatter = TimeSuffixFormatter(workTime: state.data?.workTime)

    let service: IPlacesService
    private let placeId: Int
    private var task: Task<Void, Error>?

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    /// - Parameter placeId: Id - для получения детальной информации о месте.
    init(service: IPlacesService, placeId: Int, isFavorite: Bool) {
        self.service = service
        self.placeId = placeId
        self.isFavorite = isFavorite
        self.sharedUrl = URL(string: "https://dagestan-trails.ru/place/\(placeId)")
    }

    deinit {
        task?.cancel()
    }

    func loadPlaceDetail() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            self.state = .loading

            do {
                let place = try await service.getPlace(id: placeId)
                state = .loaded(place)
            } catch {
                state = .failed(error.localizedDescription)
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }
}
