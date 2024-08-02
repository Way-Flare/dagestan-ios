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
    case routeFeedbacks(parameters: PlaceFeedbackParametersDTO)
    
    public var path: String {
        switch self {
            case .allRoutes:
                "routes/all/"
            case .route(let id):
                "routes/\(id)/"
            case .routeFeedbacks(let parameters):
                "places/\(parameters.id)/feedbacks/"
        }
    }
    
    public var method: CoreKit.Method {
        .get
    }
    
    public var headers: Headers? {
        nil
    }
    
    public var query: Parameters? {
        switch self {
            case .routeFeedbacks(let parameters):
                var query: [String: Int] = [:]
                if let pageSize = parameters.pageSize {
                    query["page_size"] = pageSize
                }
                if let pages = parameters.pages {
                    query["pages"] = pages
                }
                return query
            default:
                return nil
        }
    }
}
