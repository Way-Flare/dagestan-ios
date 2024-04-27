//
//  PlaceDetail.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation

struct PlaceDetail {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    let name: String
    let tags: [TagPlace]
    let shortDescription: String
    let description: String
    let images: [ImageDTO]
    let workTime: String
    let placeFeedbacks: [PlaceFeedback]
    let rating: Int
    let placeWays: [PlaceWay]
    let contacts: [Contact]
    let routes: [Route]
}

extension PlaceDetail {
    struct PlaceFeedback {
        let id: Int
        let images: [ImageDTO]
        let user: User
        let stars: Int
        let comment: String
        let createdAt: String
    }

    struct User {
        let username: String
        let avatar: String
    }

    struct PlaceWay {
        let id: Int
        let info: String
        let images: [ImageDTO]
    }

    struct Contact {
        let id: Int
        let phoneNumber: String
        let email: String
    }

    struct Route {
        let id: Int
        let title: String
        let shortDescription: String
        let images: [ImageDTO]
        let rating: Int
    }
}
