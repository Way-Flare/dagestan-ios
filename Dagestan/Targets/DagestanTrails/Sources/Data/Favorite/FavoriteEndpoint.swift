//
//  FavoriteEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 31.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

enum FavoriteEndpoint: ApiEndpoint {
    case favorite(id: Int, fromPlace: Bool)

    var path: String {
        switch self {
            case let .favorite(id, fromPlace):
                return fromPlace ? "places/\(id)/subscribe/" : "routes/\(id)/subscribe/"
        }
    }

    var method: CoreKit.Method {
        .post
    }

    var headers: Headers? {
        nil
    }
}
