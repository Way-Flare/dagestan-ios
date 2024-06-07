//
//  PlaceDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import Foundation

final class PlaceDetailViewModel: ObservableObject {
    @Published var place: PlaceDetail?
    
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
            
            do {
                let place = try await service.getPlace(id: placeId)
                self.place = place
            } catch {
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }
}
