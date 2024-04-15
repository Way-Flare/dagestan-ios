//
//  TabItem.swift
//  DagestanTraits
//
//  Created by Рассказов Глеб on 26.03.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

enum TabItem: Int, CaseIterable {
    case map
    case favorite
    case profile
    case route
    
    var title: String {
        switch self {
            case .map: return "tab.item.favorites"
            case .favorite: return "tab.item.favorites"
            case .profile: return "tab.item.favorites"
            case .route: return "tab.item.favorites"
        }
    }
    
    var icon: String {
        switch self {
            case .map: return "map.fill"
            case .favorite: return "star.fill"
            case .profile: return "person.fill"
            case .route: return "location.fill"
        }
    }
}
