//
//  Route.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

public struct RouteDetail {
    let id: Int
    let title: String
    let images: [URL]
    let shortDescription: String?
    let description: String?
    let places: [PlaceInRoute]
    let distance: Double
    let travelTime: String
    let feedbackCount: Int
    let rating: Double
    let isFavorite: Bool
}

public extension RouteDetail {
    struct PlaceInRoute {
        let id: Int
        let name: String
        let images: [URL]
        let workTime: String?
        let mainTag: TagPlace
        let sequence: Int
        let isFavorite: Bool
    }
}

extension RouteDetail.PlaceInRoute: Domainable {
    public typealias DomainType = RoutePlaceModel
    
    public func asDomain() -> DomainType {
        RoutePlaceModel(
            id: id,
            icon: mainTag.icon,
            title: name,
            subtitle: workTime,
            isFavorite: isFavorite
        )
    }
}

extension RouteDetail: Equatable {
    public static func == (lhs: RouteDetail, rhs: RouteDetail) -> Bool {
        lhs.id == rhs.id
    }
}
