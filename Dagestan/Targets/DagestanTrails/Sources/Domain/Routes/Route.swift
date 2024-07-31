//
//  Route.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct Route {
    let id: Int
    let title: String
    let images: [URL]
    let shortDescription: String?
    let distance: Double
    let travelTime: String
    let feedbackCount: Int
    let rating: Double
    let isFavorite: Bool
    
    func withFavoriteStatus(to status: Bool) -> Route {
        Route(
            id: id,
            title: title,
            images: images,
            shortDescription: shortDescription,
            distance: distance,
            travelTime: travelTime,
            feedbackCount: feedbackCount,
            rating: rating,
            isFavorite: status
        )
    }
    
    static let mock = Route(
        id: 1,
        title: "Маршрут 1",
        images: Place.mock.images,
        shortDescription: "Краткое описание маршрута",
        distance: 5.5,
        travelTime: "1 ч 30 мин",
        feedbackCount: 12,
        rating: 4.5,
        isFavorite: true
    )
}
