//
//  Place.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import CoreLocation

struct PlaceDTO: Decodable {
    let id: Int
    let longitude: Double
    let latitude: Double
    let name: String
    let shortDescription: String?
    let images: [ImageDTO]
    let rating: Double?
    let workTime: String?
    let tags: [TagPlaceDTO]?
    let feedbackCount: Int?
}

// MARK: - Convert to Domain model

extension PlaceDTO: Domainable {
    typealias DomainType = Place
    
    func asDomain() -> Place {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return Place(
            id: id,
            coordinate: coordinate,
            name: name,
            shortDescription: shortDescription,
            images: images.compactMap { $0.asDomain() },
            rating: rating,
            workTime: workTime,
            tags: tags?.map { $0.asDomain() },
            feedbackCount: feedbackCount
        )
    }
}
