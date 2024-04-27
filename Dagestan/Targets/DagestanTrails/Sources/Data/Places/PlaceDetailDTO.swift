//
//  PlaceDetailDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import CoreLocation

struct PlaceDetailDTO: Decodable {
    let id: Int
    let longitude: Double
    let latitude: Double
    let name: String
    let tags: [TagPlaceDTO]
    let shortDescription: String
    let description: String
    let images: [ImageDTO]
    let workTime: String
    let placeFeedbacks: [PlaceFeedbackDTO]
    let rating: Int
    let placeWays: [PlaceWayDTO]
    let contacts: [ContactDTO]
    let routes: [RouteDTO]
}

extension PlaceDetailDTO {
    struct PlaceFeedbackDTO: Decodable {
        let id: Int
        let images: [ImageDTO]
        let user: UserDTO
        let stars: Int
        let comment: String
        let createdAt: String
    }

    struct UserDTO: Decodable {
        let username: String
        let avatar: String
    }

    struct PlaceWayDTO: Decodable {
        let id: Int
        let info: String
        let images: [ImageDTO]
    }

    struct ContactDTO: Decodable {
        let id: Int
        let phoneNumber: String
        let email: String
    }

    struct RouteDTO: Decodable {
        let id: Int
        let title: String
        let shortDescription: String
        let images: [ImageDTO]
        let rating: Int
    }
}

// MARK: - Convert to Domain Model

extension PlaceDetailDTO: Domainable {
    typealias DomainType = PlaceDetail

    func asDomain() -> PlaceDetail {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        return PlaceDetail(
            id: id,
            coordinate: coordinate,
            name: name,
            tags: tags.map { $0.asDomain() },
            shortDescription: shortDescription,
            description: description,
            images: images,
            workTime: workTime,
            placeFeedbacks: placeFeedbacks.map { $0.asDomain() },
            rating: rating,
            placeWays: placeWays.map { $0.asDomain() },
            contacts: contacts.map { $0.asDomain() },
            routes: routes.map { $0.asDomain() }
        )
    }
}

extension PlaceDetailDTO.PlaceFeedbackDTO: Domainable {
    typealias DomainType = PlaceDetail.PlaceFeedback
    
    func asDomain() -> PlaceDetail.PlaceFeedback {
        PlaceDetail.PlaceFeedback(
            id: id,
            images: images,
            user: user.asDomain(),
            stars: stars,
            comment: comment,
            createdAt: createdAt
        )
    }
}

extension PlaceDetailDTO.UserDTO: Domainable {
    typealias DomainType = PlaceDetail.User
    
    func asDomain() -> PlaceDetail.User {
        PlaceDetail.User(
            username: username,
            avatar: avatar
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
            email: email
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
            images: images,
            rating: rating
        )
    }
}
