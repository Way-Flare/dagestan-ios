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
            case .places: return "tab.places"
            case .favorite: return "tab.favorites"
            case .profile: return "tab.profile"
            case .routes: return "tab.routes"
            case .designSystem: return "DesignSystem"
            case .navigationSanbox : return "Navigator"
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
