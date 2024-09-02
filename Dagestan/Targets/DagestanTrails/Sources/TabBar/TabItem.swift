//
//  TabItem.swift
//  DagestanTraits
//
//  Created by Рассказов Глеб on 26.03.2024.
//

import CoreKit
import SwiftUI

enum TabItem: Int, CaseIterable {
    case places
    case routes
    case favorite
    case profile
    case designSystem
    case navigationSanbox

    static var visibleCases: [Self] {
        var defaultCases: [Self] = [.places, .routes, .favorite, .profile]
        let debugCases: [Self] = [.designSystem, .navigationSanbox]
        #if DEBUG
        defaultCases.append(contentsOf: debugCases)
        #endif
        return defaultCases
    }

    var title: String {
        switch self {
            case .places: return "Места"
            case .favorite: return "Избранные"
            case .profile: return "Профиль"
            case .routes: return "Маршруты"
            case .designSystem: return "Дизайн система"
            case .navigationSanbox : return "Навигатор"
        }
    }

    var icon: Image {
        switch self {
            case .places:
                DagestanTrailsAsset.tabLocation.swiftUIImage
            case .routes:
                DagestanTrailsAsset.tabRoute.swiftUIImage
            case .favorite:
                DagestanTrailsAsset.tabHeart.swiftUIImage
            case .profile:
                DagestanTrailsAsset.tabProfileCircle.swiftUIImage
            case .designSystem:
                Image(systemName: "eye")
            case .navigationSanbox:
                Image(systemName: "location")
        }
    }
}
