//
//  PlaceAnalytics.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 30.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import CoreLocation

struct PlaceAnalyticEventInfo {
    let id: Int
    let name: String?
    let coordinate: CLLocationCoordinate2D?
}

extension Place {
    func asAnalyticsData() -> PlaceAnalyticEventInfo {
        .init(id: id, name: name, coordinate: coordinate)
    }
}

extension PlaceDetail {
    func asAnalyticsData() -> PlaceAnalyticEventInfo {
        .init(id: id, name: name, coordinate: coordinate)
    }
}

extension RoutePlaceModel {
    func asAnalyticsData() -> PlaceAnalyticEventInfo {
        .init(id: id, name: title, coordinate: nil)
    }
}

enum PlaceAnalytics {
    case loadedPlaceDetailInfo(place: PlaceAnalyticEventInfo)
    case favoriteAction(isAdded: Bool, id: Int)
    case loadedPromocode(place: PlaceAnalyticEventInfo)
    case failed(place: PlaceAnalyticEventInfo, error: String)
}

extension PlaceAnalytics: AnalyticsProtocol {
    var eventId: String {
        switch self {
            case .loadedPlaceDetailInfo:
                return "Пользователь_открыл_детальную_страницу_места"
            case .favoriteAction:
                return "Пользователь_добавил/удалил_место_в_избранное"
            case .loadedPromocode:
                return "Пользователь_получил_промокоды"
            case .failed:
                return "Произошла_ошибка_при_работе_с_местом"
        }
    }

    var parameters: [String: Any] {
        switch self {
            case .loadedPlaceDetailInfo(let place):
                var params: [String: Any] = [:]
                params[place.name ??  "\(place.id)"] = [
                    "id": place.id,
                    "latitude": place.coordinate?.latitude ?? .zero,
                    "longitude": place.coordinate?.longitude ?? .zero,
                ]
                return params
            case .favoriteAction(let isAdded, let id):
                return ["\(id)": isAdded]
            case .loadedPromocode(let place):
                var params: [String: Any] = [:]
                params[place.name ?? "\(place.id)"] = [
                    "id": place.id,
                    "latitude": place.coordinate?.latitude ?? .zero,
                    "longitude": place.coordinate?.longitude ?? .zero,
                ]
                return params
            case .failed(place: let place, error: let error):
                var params: [String: Any] = [:]
                params[place.name ?? "\(place.id)"] = [
                    "id": place.id,
                    "latitude": place.coordinate?.latitude ?? .zero,
                    "longitude": place.coordinate?.longitude ?? .zero,
                    "error": error
                ]
                return params
        }
    }
}
