//
//  DTButtonPrimary.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct DTButtonPrimary: DTButtonStyle {
    public var `default`: DTButtonAppearance = DTButtonPrimaryDefault()
    public var hover: DTButtonAppearance = DTButtonPrimaryHover()
    public var active: DTButtonAppearance = DTButtonPrimaryActive()
    public var disabled: DTButtonAppearance = DTButtonPrimaryDisabled()
}

private struct DTButtonPrimaryDefault: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentPrimary
}

private struct DTButtonPrimaryHover: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentHover
}

private struct DTButtonPrimaryActive: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentActive
}

private struct DTButtonPrimaryDisabled: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.accentPrimary.opacity(0.5)
}

public extension DTButtonStyle where Self == DTButtonPrimary {
    static var primary: DTButtonPrimary {
        DTButtonPrimary()
    }
}
