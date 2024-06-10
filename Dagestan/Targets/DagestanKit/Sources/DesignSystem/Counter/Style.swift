//
//  Style.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public extension DKCounter {
    enum Style {
        case accent
        case notification
        case nature
        case clear
        
        var foregroundColor: Color {
            switch self {
                case .accent, .notification: return DagestanKitAsset.onAccent.swiftUIColor
                case .nature, .clear: return DagestanKitAsset.fgDefault.swiftUIColor
            }
        }
        
        var backgroundColor: Color {
            switch self {
                case .accent: return DagestanKitAsset.iconAccent.swiftUIColor
                case .notification: return DagestanKitAsset.errorSoft.swiftUIColor
                case .nature: return DagestanKitAsset.bgSurface3.swiftUIColor
                case .clear: return .clear
            }
        }
    }
}
