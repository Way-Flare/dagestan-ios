//
//  WrappedEntities.swift
//  CoreKit
//
//  Created by Рассказов Глеб on 03.05.2024.
//

import Foundation
import DesignSystem

extension ButtonExampleView {
    enum WrappedButtonType: String, CaseIterable {
        case primary = "Primary"
        case secondary = "Secondary"
        case ghost = "Ghost"
        case nature = "Nature"
        case overlay = "Overlay"
        case favorite = "Favorite"

        var buttonType: WFButtonStyle {
            switch self {
                case .primary: return .primary
                case .secondary: return .secondary
                case .ghost: return .ghost
                case .nature: return .nature
                case .overlay: return .overlay
                case .favorite: return .favorite
            }
        }
    }

    enum WrappedButtonSize: String, CaseIterable {
        case l, m, s, xs

        var buttonSize: WFButton.Size {
            switch self {
                case .l: return .l
                case .m: return .m
                case .s: return .s
                case .xs: return .xs
            }
        }

        var buttonIconSize: WFButtonIcon.Size {
            switch self {
                case .l: return .l
                case .m: return .m
                case .s: return .s
                case .xs: return .xs
            }
        }
    }

    enum WrappedButtonState: String, CaseIterable {
        case `default`
        case hover
        case active
        case disabled

        var buttonState: WFButtonState {
            switch self {
                case .default: return .default
                case .hover: return .hover
                case .active: return .active
                case .disabled: return .disabled
            }
        }
    }
}
