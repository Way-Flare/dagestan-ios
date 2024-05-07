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
    var foregroundColor: Color = .dtColor(named: "onAccent")
    var backgroundColor: Color = .dtColor(named: "accentDefault")
}

private struct DTButtonPrimaryHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "onAccent")
    var backgroundColor: Color = .dtColor(named: "accentHover")
}

private struct DTButtonPrimaryActive: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "onAccent")
    var backgroundColor: Color = .dtColor(named: "accentActive")
}

private struct DTButtonPrimaryDisabled: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "onAccent")
    var backgroundColor: Color = .dtColor(named: "accentDefault").opacity(0.5)
}

extension DTButtonStyle where Self == DTButtonPrimary {
    static var primary: DTButtonPrimary {
        DTButtonPrimary()
    }
}
