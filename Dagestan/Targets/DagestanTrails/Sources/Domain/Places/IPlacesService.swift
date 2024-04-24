//
//  IPlacesService.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 24.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

/// Интерфейс/protocol сервиса для работы с точками/местами
protocol IPlacesService {
    /// Получение всех мест
    /// - Returns: [Place] - массив мест
    func getAllPlaces() async throws -> [Place]
}
