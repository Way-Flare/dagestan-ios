//
//  WFButtonSecondary.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct WFButtonSecondary: WFButtonStyle {
    public var `default`: WFButtonAppearance = WFButtonSecondaryDefault()
    public var hover: WFButtonAppearance = WFButtonSecondaryHover()
    public var active: WFButtonAppearance = WFButtonSecondaryActive()
    public var disabled: WFButtonAppearance = WFButtonSecondaryDisabled()
    public var loading: WFButtonAppearance = WFButtonSecondaryLoading()
    
    public init() {}
}

private struct WFButtonSecondaryDefault: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerPrimary
}

private struct WFButtonSecondaryHover: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerHover
}

private struct WFButtonSecondaryActive: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerActive
}

private struct WFButtonSecondaryDisabled: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary.opacity(0.5)
    var backgroundColor: Color = WFColor.accentContainerPrimary.opacity(0.5)
}

private struct WFButtonSecondaryLoading: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary.opacity(0.5)
    var backgroundColor: Color = .clear
}

public extension WFButtonStyle where Self == WFButtonSecondary {
    static var secondary: WFButtonSecondary {
        WFButtonSecondary()
    }
}
