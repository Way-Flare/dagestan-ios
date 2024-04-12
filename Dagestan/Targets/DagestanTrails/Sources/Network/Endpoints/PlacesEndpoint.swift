//
//  PlacesEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 12.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

enum PlacesEndpoint: Endpoint {
    case places
    
    var path: String {
        switch self {
        case .places:
            return API.PlacesAPI.fetchPlaces
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}
