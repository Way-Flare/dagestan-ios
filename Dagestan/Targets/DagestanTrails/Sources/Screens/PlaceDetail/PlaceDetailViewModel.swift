//
//  PlaceDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import Foundation

class MockPlaceService: IPlacesService {
    func getAllPlaces() async throws -> [Place] {
        [
            Place.mock,
            Place.mock,
            Place.mock,
            Place.mock
        ]
    }

    func getPlace(id: Int) async throws -> PlaceDetail {
//        try await Task.sleep(nanoseconds: 2_000_000_000)
        return PlaceDetail.mock()
    }
}

final class PlaceDetailViewModel: ObservableObject {
    @Published var state: LoadingState<PlaceDetail> = .idle
    @Published var isVisibleSnackbar = false
    
    lazy var formatter = TimeSuffixFormatter(workTime: state.data?.workTime)

    private let service: IPlacesService
    private let placeId: Int
    private var task: Task<Void, Error>?

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    /// - Parameter placeId: Id - для получения детальной информации о месте.
    init(service: IPlacesService, placeId: Int) {
        self.service = service
        self.placeId = placeId
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
                state = .failed(error)
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }
}
