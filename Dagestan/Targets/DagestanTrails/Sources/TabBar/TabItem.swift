//
//  TabItem.swift
//  DagestanTraits
//
//  Created by Рассказов Глеб on 26.03.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

enum TabItem: Int, CaseIterable {
    case map
    case route
    case favorite
    case profile
    case dagestankit

    var title: String {
        switch self {
            case .map: return "Карта"
            case .route: return "Маршруты"
            case .favorite: return "Избранное"
            case .profile: return "Профиль"
            case .dagestankit: return "DagestanKit"
        }
    }

    var icon: Image {
        switch self {
            case .map: return DagestanKitAsset.locationMapOutline.swiftUIImage
            case .route: return DagestanKitAsset.locationRoutingLinear.swiftUIImage
            case .favorite: return DagestanKitAsset.supportHeartLinear.swiftUIImage
            case .profile: return DagestanKitAsset.userProfileCircleLinear.swiftUIImage
            case .dagestankit: return DagestanKitAsset.archiveOutline.swiftUIImage
        }
    }
}
