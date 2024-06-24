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
}

public extension RouteDetail {
    struct PlaceInRoute {
        let id: Int
        let images: [URL]
        let workTime: String?
        let mainTag: TagPlace
        let sequence: Int
    }
}

extension RouteDetail.PlaceInRoute: Domainable {
    public typealias DomainType = RoutePlaceModel
    
    public func asDomain() -> DomainType {
        RoutePlaceModel(
            icon: mainTag.icon,
            title: "Каньон реки Сулак", // тут временно так как тут какая то херня с images не пон нах и что вооб
            subtitle: workTime
        )
    }
}
