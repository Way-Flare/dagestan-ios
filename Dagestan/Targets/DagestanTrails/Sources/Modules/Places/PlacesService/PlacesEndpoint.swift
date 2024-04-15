//
//  PlacesEndpoint.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import DagestanKit

enum PlacesEndpoint {
    case allPlaces
}

extension PlacesEndpoint: ApiEndpoint {

    var path: String {
        switch self {
        case .allPlaces:
            return "places/all"
        }
    }

    var method: DagestanKit.Method { return .get }

    var headers: Headers? {
        return nil
    }

}

struct Place: Decodable {
    let id: Int
    let longitude: Double
    let latitude: Double
    let name: String
}
