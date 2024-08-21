//
//  RouteDetailDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct RouteDTO: Decodable {
    let id: Int
    let title: String
    let images: [ImageDTO]
    let shortDescription: String?
    let distance: Double
    let travelTime: String
    let feedbackCount: Int
    let rating: Double
    let placesCount: Int
    let isFavorite: Bool
}

extension RouteDTO: Domainable {
    typealias DomainType = Route

    func asDomain() -> DomainType {
        Route(
            id: id,
            title: title,
            images: images.compactMap { $0.asDomain() },
            shortDescription: shortDescription,
            distance: distance,
            travelTime: travelTime,
            feedbackCount: feedbackCount,
            rating: rating,
            placesCount: placesCount,
            isFavorite: isFavorite
        )
    }
}
