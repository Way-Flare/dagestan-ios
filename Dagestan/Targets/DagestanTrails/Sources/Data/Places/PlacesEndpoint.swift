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
    case placeFeedbacks(parameters: PlaceFeedbackParametersDTO)
}

extension PlacesEndpoint: ApiEndpoint {
    
    var path: String {
        switch self {
            case .allPlaces:
                return "places/all/"
            case let .place(id):
                return "places/\(id)/"
            case .placeFeedbacks(let parameters):
                return "places/\(parameters.id)/feedbacks/"
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

    var query: Parameters? {
        switch self {
            case .placeFeedbacks(let parameters):
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
