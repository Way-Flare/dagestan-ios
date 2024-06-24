//
//  RouteDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct RouteDetailDTO: Decodable {
    let id: Int
    let title: String
    let images: [ImageDTO]
    let shortDescription: String?
    let description: String?
    let places: [PlaceInRouteDTO]
    let distance: Double
    let travelTime: String
    let feedbackCount: Int
    let rating: Double
}

extension RouteDetailDTO {
    struct PlaceInRouteDTO: Decodable {
        let id: Int
        let images: [ImageDTO]
        let workTime: String?
        let mainTag: TagPlaceDTO
        let sequence: Int
    }
}

// MARK: - Domainable

extension RouteDetailDTO: Domainable {
    typealias DomainType = RouteDetail

    func asDomain() -> RouteDetail {
        RouteDetail(
            id: id,
            title: title,
            images: images.compactMap { $0.asDomain() },
            shortDescription: shortDescription,
            description: description,
            places: places.map { $0.asDomain() },
            distance: distance,
            travelTime: travelTime,
            feedbackCount: feedbackCount,
            rating: rating
        )
    }
}

extension RouteDetailDTO.PlaceInRouteDTO: Domainable {
    typealias DomainType = RouteDetail.PlaceInRoute

    func asDomain() -> RouteDetail.PlaceInRoute {
        RouteDetail.PlaceInRoute(
            id: id,
            images: images.compactMap { $0.asDomain() },
            workTime: workTime,
            mainTag: mainTag.asDomain(),
            sequence: sequence
        )
    }
}
