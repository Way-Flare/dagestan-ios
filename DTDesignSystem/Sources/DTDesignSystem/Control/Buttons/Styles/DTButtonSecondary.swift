//
//  DTButtonSecondary.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct DTButtonSecondary: DTButtonStyle {
    public var `default`: DTButtonAppearance = DTButtonSecondaryDefault()
    public var hover: DTButtonAppearance = DTButtonSecondaryHover()
    public var active: DTButtonAppearance = DTButtonSecondaryActive()
    public var disabled: DTButtonAppearance = DTButtonSecondaryDisabled()
}

private struct DTButtonSecondaryDefault: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerPrimary
}

private struct DTButtonSecondaryHover: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerHover
}

private struct DTButtonSecondaryActive: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerActive
}

private struct DTButtonSecondaryDisabled: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary.opacity(0.5)
    var backgroundColor: Color = WFColor.accentContainerPrimary.opacity(0.5)
}

public extension DTButtonStyle where Self == DTButtonSecondary {
    static var secondary: DTButtonSecondary {
        DTButtonSecondary()
    }
}
