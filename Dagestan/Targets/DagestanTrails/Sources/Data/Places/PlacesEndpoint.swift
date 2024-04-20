//
//  PlacesEndpoint.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation
import DagestanKit

enum PlacesEndpoint {
    case allPlaces
    case place(id: Int)
}

extension PlacesEndpoint: ApiEndpoint {
    
    var path: String {
        switch self {
            case .allPlaces:
                return "places/all"
            case .place(let id):
                return "places/\(id)"
        }
    }
    
    var method: DagestanKit.Method { return .get }
    
    var headers: Headers? {
        return nil
    }
}
