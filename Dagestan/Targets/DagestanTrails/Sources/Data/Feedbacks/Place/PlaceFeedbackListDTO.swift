//
//  PlaceFeedbackListDTO.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct PlaceFeedbackListDTO: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlaceFeedbackDTO]
}

// MARK: - Domainable

extension PlaceFeedbackListDTO: Domainable {
    typealias DomainType = PlaceFeedbackList

    func asDomain() -> PlaceFeedbackList {
        return PlaceFeedbackList(
            count: count,
            next: URL(string: next ?? ""),
            previous: URL(string: previous ?? ""),
            results: results.map { $0.asDomain() }
        )
    }
}
