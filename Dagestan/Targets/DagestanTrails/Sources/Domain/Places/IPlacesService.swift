//
//  IPlacesService.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 24.04.2024.
//

import Foundation

/// Интерфейс/protocol сервиса для работы с точками/местами
protocol IPlacesService {
    /// Получение всех мест
    /// - Returns: [Place] - массив мест
    func getAllPlaces() async throws -> [Place]
    /// Получение конкретного места
    /// - Returns: PlaceDetail - детальное место
    func getPlace(id: Int) async throws -> PlaceDetail
    
    func setFavorite(by id: Int) async throws -> Bool
}
