//
//  TabItem.swift
//  DagestanTraits
//
//  Created by Рассказов Глеб on 26.03.2024.
//

import DagestanKit
import SwiftUI

enum TabItem: Int, CaseIterable {
    case places
    case routes
    case favorite
    case profile
    case dagestankit

    var title: String {
        switch self {
            case .places: return "tab.places"
            case .favorite: return "tab.favorites"
            case .profile: return "tab.profile"
            case .routes: return "tab.routes"
            case .dagestankit: return "DesignSystem"
        }
    }

    var selectedIcon: Image {
        switch self {
            case .places:
                DagestanTrailsAsset.tabLocationSelected.swiftUIImage
            case .routes:
                DagestanTrailsAsset.tabRouteSelected.swiftUIImage
            case .favorite:
                DagestanTrailsAsset.tabHeartSelected.swiftUIImage
            case .profile:
                DagestanTrailsAsset.tabProfileCircleSelected.swiftUIImage
            case .dagestankit:
                DagestanTrailsAsset.hideSoft.swiftUIImage
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
            case .dagestankit:
                DagestanTrailsAsset.viewSoft.swiftUIImage
        }
    }

}
