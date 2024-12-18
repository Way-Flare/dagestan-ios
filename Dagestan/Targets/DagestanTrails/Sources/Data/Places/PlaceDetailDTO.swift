//
//  PlaceDetailDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.04.2024.
//

import CoreKit
import CoreLocation

struct PlaceDetailDTO: Decodable {
    let id: Int
    let longitude: Double
    let latitude: Double
    let name: String
    let address: String?
    let tags: [TagPlaceDTO]
    let shortDescription: String?
    let description: String?
    let images: [ImageDTO]
    let workTime: String?
    let rating: Double
    let placeWays: [PlaceWayDTO]
    let contacts: [ContactDTO]
    let routes: [RouteDTO]
    let feedbackCount: Int
    let isFavorite: Bool
    let isPromocode: Bool
}

extension PlaceDetailDTO {
    struct PlaceWayDTO: Decodable {
        let id: Int
        let info: String?
        let images: [ImageDTO]
    }

    struct ContactDTO: Decodable {
        let id: Int
        let phoneNumber: String?
        let email: String?
        let site: String?
    }

    struct RouteDTO: Decodable {
        let id: Int
        let title: String
        let shortDescription: String?
        let images: [ImageDTO]
        let rating: Double
        let distance: Double
        let travelTime: String
        let isFavorite: Bool
        let placesCount: Int
    }
}

// MARK: - Domainable

extension PlaceDetailDTO: Domainable {
    typealias DomainType = PlaceDetail

    func asDomain() -> PlaceDetail {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        return PlaceDetail(
            id: id,
            coordinate: coordinate,
            name: name,
            address: address,
            tags: tags.map { $0.asDomain() },
            shortDescription: shortDescription,
            description: description,
            images: images.compactMap { $0.asDomain() },
            workTime: workTime,
            rating: rating,
            placeWays: placeWays.map { $0.asDomain() },
            contacts: contacts.map { $0.asDomain() },
            routes: routes.map { $0.asDomain() },
            isFavorite: isFavorite,
            feedbackCount: feedbackCount,
            isPromocode: isPromocode
        )
    }
}

extension PlaceDetailDTO.PlaceWayDTO: Domainable {
    typealias DomainType = PlaceDetail.PlaceWay

    func asDomain() -> PlaceDetail.PlaceWay {
        PlaceDetail.PlaceWay(
            id: id,
            info: info,
            images: images
        )
    }
}

extension PlaceDetailDTO.ContactDTO: Domainable {
    typealias DomainType = PlaceDetail.Contact

    func asDomain() -> PlaceDetail.Contact {
        PlaceDetail.Contact(
            id: id,
            phoneNumber: phoneNumber,
            email: email,
            site: site
        )
    }
}

extension PlaceDetailDTO.RouteDTO: Domainable {
    typealias DomainType = PlaceDetail.Route

    func asDomain() -> PlaceDetail.Route {
        PlaceDetail.Route(
            id: id,
            title: title,
            shortDescription: shortDescription,
            images: [],
            rating: rating,
            distance: distance,
            travelTime: travelTime,
            isFavorite: isFavorite,
            placesCount: placesCount
        )
    }
}
