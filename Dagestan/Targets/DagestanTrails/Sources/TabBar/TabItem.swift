//
//  TabItem.swift
//  DagestanTraits
//
//  Created by Рассказов Глеб on 26.03.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit

enum TabItem: Int, CaseIterable {
    case map
    case route
    case favorite
    case profile
    case dagestankit

    var title: String {
        switch self {
            case .map: return "Карта"
            case .favorite: return "Избранное"
            case .profile: return "Профиль"
            case .route: return "Маршруты"
            case .dagestankit: return "DagestanKit"
        }
    }

    var icon: String {
        switch self {
            case .map: return "map.fill"
            case .favorite: return "star.fill"
            case .profile: return "person.fill"
            case .route: return "location.fill"
            case .dagestankit: return "arkit"
        }
    }
}
