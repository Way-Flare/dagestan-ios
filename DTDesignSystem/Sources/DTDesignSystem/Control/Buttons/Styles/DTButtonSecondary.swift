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
    var foregroundColor: Color = .dtColor(named: "accentDefault")
    var backgroundColor: Color = .dtColor(named: "accentContainerDefault")
}

private struct DTButtonSecondaryHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentDefault")
    var backgroundColor: Color = .dtColor(named: "accentContainerHover")
}

private struct DTButtonSecondaryActive: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentDefault")
    var backgroundColor: Color = .dtColor(named: "accentContainerActive")
}

private struct DTButtonSecondaryDisabled: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentDefault").opacity(0.5)
    var backgroundColor: Color = .dtColor(named: "accentContainerDefault").opacity(0.5)
}

extension DTButtonStyle where Self == DTButtonSecondary {
    static var secondary: DTButtonSecondary {
        DTButtonSecondary()
    }
}
