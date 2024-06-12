//
//  Style.swift
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import SwiftUI

public extension WFCounter {
    enum Style {
        case accent
        case notification
        case nature
        case clear

        var foregroundColor: Color {
            switch self {
                case .accent, .notification: return WFColor.accentInverted
                case .nature, .clear: return WFColor.foregroundPrimary
            }
        }

        var backgroundColor: Color {
            switch self {
                case .accent: return WFColor.iconAccent
                case .notification: return WFColor.errorSoft
                case .nature: return WFColor.surfaceTertiary
                case .clear: return .clear
            }
        }
    }
}
