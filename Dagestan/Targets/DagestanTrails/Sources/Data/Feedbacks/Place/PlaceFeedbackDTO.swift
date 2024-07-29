//
//  PlaceFeedbackDTO.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit

struct PlaceFeedbackDTO: Decodable {
    let id: Int
    let images: [ImageDTO]
    let user: UserDTO
    let stars: Int
    let comment: String?
    let createdAt: String
}

// MARK: - Domainable

extension PlaceFeedbackDTO: Domainable {
    typealias DomainType = PlaceFeedback

    func asDomain() -> PlaceFeedback {
        PlaceFeedback(
            id: id,
            images: images.compactMap { $0.asDomain() },
            user: user.asDomain(),
            stars: stars,
            comment: comment,
            createdAt: createdAt
        )
    }
}
