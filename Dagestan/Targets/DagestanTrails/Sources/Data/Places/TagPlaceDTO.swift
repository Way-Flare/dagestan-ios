//
//  TagPlace.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//

import CoreKit

public struct TagPlaceDTO: Decodable {
    public let id: Int
    public let name: String
}

// MARK: - Domainable

extension TagPlaceDTO: Domainable {
    public func asDomain() -> TagPlace {
        return TagPlace(rawValue: name)
    }
}
