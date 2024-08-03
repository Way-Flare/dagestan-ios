//
//  PlaceDetail.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.04.2024.
//

import CoreLocation
import CoreKit

struct PlaceDetail {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    let name: String
    let address: String?
    let tags: [TagPlace]
    let shortDescription: String?
    let description: String?
    let images: [URL]
    let workTime: String?
    let rating: Double
    let placeWays: [PlaceWay]
    let contacts: [Contact]
    let routes: [Route]
    let isFavorite: Bool
    let feedbackCount: Int
}

extension PlaceDetail {
    struct PlaceWay {
        let id: Int
        let info: String?
        let images: [URL]
    }

    struct Contact {
        let id: Int
        let phoneNumber: String?
        let email: String?
        let site: String?
    }

    struct Route {
        let id: Int
        let title: String
        let shortDescription: String?
        let images: [URL]
        let rating: Int
        let distance: Double
        let travelTime: String
        let isFavorite: Bool
        let placesCount: Int
    }
}

extension PlaceDetail.Route: Domainable {
    typealias DomainType = RoutePlaceModel
    
    func asDomain() -> DomainType {
        .init(
            id: id,
            icon: TagPlace.nature.icon,
            title: title,
            subtitle: shortDescription,
            isFavorite: isFavorite
        )
    }
}

extension PlaceDetail: Domainable {
    func asDomain() -> ReviewModel {
        .init(
            id: id,
            image: images.first,
            name: name,
            address: address,
            rating: rating,
            feedbackCount: feedbackCount
        )
    }
}

extension PlaceDetail: Equatable {
    static func == (lhs: PlaceDetail, rhs: PlaceDetail) -> Bool {
        lhs.id == rhs.id
    }
}
