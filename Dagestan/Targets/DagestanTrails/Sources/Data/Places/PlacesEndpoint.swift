//
//  PlacesEndpoint.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//

import CoreLocation
import CoreKit

enum PlacesEndpoint {
    case allPlaces
    case place(id: Int)
    case favorite(id: Int)
}

extension PlacesEndpoint: ApiEndpoint {
    
    var path: String {
        switch self {
            case .allPlaces:
                return "places/all/"
            case let .place(id):
                return "places/\(id)/"
            case let .favorite(id):
                return "places/\(id)/subscribe/"
        }
    }
    
    var method: CoreKit.Method {
        switch self {
            case .favorite:
                return .post
            default:
                return .get
        }
    }

    var headers: Headers? {
        return nil
    }
}
