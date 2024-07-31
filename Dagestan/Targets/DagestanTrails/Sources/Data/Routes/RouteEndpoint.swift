//
//  RouteEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit

public enum RouteEndpoint: ApiEndpoint {
    case allRoutes
    case route(id: Int)
    
    public var path: String {
        switch self {
            case .allRoutes:
                "routes/all/"
            case let .route(id):
                "routes/\(id)/"
        }
    }
    
    public var method: CoreKit.Method {
        .get
    }
    
    public var headers: Headers? {
        nil
    }
}
