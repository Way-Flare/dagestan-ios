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

    var title: String {
        switch self {
            case .places: return "tab.places"
            case .favorite: return "tab.favorites"
            case .profile: return "tab.profile"
            case .routes: return "tab.routes"
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
        }
    }
}
