//
//  WFButtonPrimary.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct WFButtonPrimary: WFButtonStyle {
    public var `default`: WFButtonAppearance = WFButtonPrimaryDefault()
    public var hover: WFButtonAppearance = WFButtonPrimaryHover()
    public var active: WFButtonAppearance = WFButtonPrimaryActive()
    public var disabled: WFButtonAppearance = WFButtonPrimaryDisabled()
    public var loading: WFButtonAppearance = WFButtonPrimaryLoading()
}

private struct WFButtonPrimaryDefault: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentPrimary
}

private struct WFButtonPrimaryHover: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentHover
}

private struct WFButtonPrimaryActive: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentActive
}

private struct WFButtonPrimaryDisabled: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentPrimary.opacity(0.5)
}

private struct WFButtonPrimaryLoading: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = .clear
}

public extension WFButtonStyle where Self == WFButtonPrimary {
    static var primary: WFButtonPrimary {
        WFButtonPrimary()
    }
}
