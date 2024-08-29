//
//  WFButtonNature.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct WFButtonNature: WFButtonStyle {
    public var `default`: WFButtonAppearance = WFButtonNatureDefault()
    public var hover: WFButtonAppearance = WFButtonNatureHover()
    public var active: WFButtonAppearance = WFButtonNatureActive()
    public var disabled: WFButtonAppearance = WFButtonNatureDisabled()
    public var loading: WFButtonAppearance = WFButtonNatureLoading()

    public init() {}
}

private struct WFButtonNatureDefault: WFButtonAppearance {
    var foregroundColor: Color = WFColor.iconPrimary
    var backgroundColor: Color = WFColor.surfaceTertiary
}

private struct WFButtonNatureHover: WFButtonAppearance {
    var foregroundColor: Color = WFColor.iconPrimary
    var backgroundColor: Color = WFColor.surfaceQuaternary
}

private struct WFButtonNatureActive: WFButtonAppearance {
    var foregroundColor: Color = WFColor.iconPrimary
    var backgroundColor: Color = WFColor.surfaceFivefold
}

private struct WFButtonNatureDisabled: WFButtonAppearance {
    var foregroundColor: Color = WFColor.iconPrimary.opacity(0.5)
    var backgroundColor: Color = WFColor.surfaceTertiary.opacity(0.5)
}


private struct WFButtonNatureLoading: WFButtonAppearance {
    var foregroundColor: Color = WFColor.iconPrimary.opacity(0.5)
    var backgroundColor: Color = .clear
}

public extension WFButtonStyle where Self == WFButtonNature {
    static var nature: WFButtonNature {
        WFButtonNature()
    }
}
