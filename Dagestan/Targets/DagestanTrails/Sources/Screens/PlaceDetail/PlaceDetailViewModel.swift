//
//  PlaceDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import Foundation

class MockPlaceService: IPlacesService {
    func getPlaceFeedbacks(parameters: PlaceFeedbackParametersDTO) async throws -> PlaceFeedbackList {
        PlaceFeedbackList(count: 1, next: nil, previous: nil, results: [PlaceFeedback.mock()])
    }
    
    func getAllPlaces() async throws -> [Place] {
        [
            Place.mock,
            Place.mock,
            Place.mock,
            Place.mock
        ]
    }
    
    func getPlace(id: Int) async throws -> PlaceDetail {
        // try await Task.sleep(nanoseconds: 2_000_000_000)
        return PlaceDetail.mock()
    }
}

protocol IPlaceDetailViewModel: ObservableObject {
    var state: LoadingState<PlaceDetail> { get }
    var placeFeedbacks: LoadingState<PlaceFeedbackList> { get }
    var isVisibleSnackbar: Bool { get set }
    var isBackdropVisible: Bool { get set }
    var formatter: TimeSuffixFormatter { get }
    
    func loadPlaceDetail()
    func loadPlaceFeedbacks()
}

final class PlaceDetailViewModel: IPlaceDetailViewModel {
    @Published var state: LoadingState<PlaceDetail> = .idle
    @Published var placeFeedbacks: LoadingState<PlaceFeedbackList> = .idle
    @Published var isVisibleSnackbar = false
    @Published var isBackdropVisible = false

    lazy var formatter = TimeSuffixFormatter(workTime: state.data?.workTime)

    private var isLoadingMoreCharacters: Bool = false
    private let service: IPlacesService
    private let placeId: Int

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    /// - Parameter placeId: Id - для получения детальной информации о месте.
    init(service: IPlacesService, placeId: Int) {
        self.service = service
        self.placeId = placeId
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

}
