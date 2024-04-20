//
//  PlaceDetailDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit

struct PlaceDetailDTO {
    let id: Int
    let longitude: Int
    let latitude: Int
    let name: String
    let shortDescription: String
    let description: String
    let images: [ImageDTO]
    let workTime: String
    let placeFeedbacks: [String]
    let rating: Double
    let placeWays: [String]
    let contacts: [String]
    let routes: [String]
}


// MARK: - Convert to Domain Model

extension PlaceDetailDTO: Domainable {
    typealias DomainType = PlaceDetail
    
    func asDomain() -> PlaceDetail {
        return PlaceDetail()
    }
}
