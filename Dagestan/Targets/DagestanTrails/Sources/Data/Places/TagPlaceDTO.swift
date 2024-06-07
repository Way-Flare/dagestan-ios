//
//  TagPlace.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//

import DagestanKit

public struct TagPlaceDTO: Decodable {
    public let id: Int
    public let name: String
}

// MARK: - Convert to Domain model
extension TagPlaceDTO: Domainable {
    public func asDomain() -> TagPlace {
        return TagPlace(rawValue: name) ?? .unknown
    }
}
