//
//  TagPlace.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit

public struct TagPlaceDTO: Decodable {
    let id: Int
    let name: String
}

extension TagPlaceDTO: Domainable {
    public typealias DomainType = TagPlace
    
    public func asDomain() -> TagPlace {
        return TagPlace(rawValue: name) ?? .unknown
    }
}
