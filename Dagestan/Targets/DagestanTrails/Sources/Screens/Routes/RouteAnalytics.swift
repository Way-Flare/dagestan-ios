//
//  RouteAnalytics.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 01.09.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit

struct RouteAnalyticEventInfo {
    let id: Int
    let name: String?
}

extension Route {
    func asAnalyticsData() -> RouteAnalyticEventInfo {
        .init(id: id, name: title)
    }
}

extension RouteDetail {
    func asAnalyticsData() -> RouteAnalyticEventInfo {
        .init(id: id, name: title)
    }
}

extension RoutePlaceModel {
    func asAnalyticsData() -> RouteAnalyticEventInfo {
        .init(id: id, name: title)
    }
}

enum RouteAnalytics {
    case loadedRouteDetailInfo(route: RouteAnalyticEventInfo)
    case favoriteAction(isAdded: Bool, id: Int)
    case failed(route: RouteAnalyticEventInfo, error: String)
}

extension RouteAnalytics: AnalyticsProtocol {
    var eventId: String {
        switch self {
            case .loadedRouteDetailInfo:
                return "Пользователь_открыл_детальную_страницу_маршрута"
            case .favoriteAction:
                return "Пользователь_добавил/удалил_маршрут_в_избранное"
            case .failed:
                return "Произошла_ошибка_при_работе_с_маршрутом"
        }
    }

    var parameters: [String: Any] {
        switch self {
            case .loadedRouteDetailInfo(let route):
                var params: [String: Any] = [:]
                params[route.name ??  "\(route.id)"] = [
                    "id": route.id,
                ]
                return params
            case .favoriteAction(let isAdded, let id):
                return ["\(id)": isAdded]
            case .failed(route: let route, error: let error):
                var params: [String: Any] = [:]
                params[route.name ?? "\(route.id)"] = [
                    "id": route.id,
                    "error": error
                ]
                return params
        }
    }
}
