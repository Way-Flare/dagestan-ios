//
//  DTButtonNature.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct DTButtonNature: DTButtonStyle {
    public var `default`: DTButtonAppearance = DTButtonNatureDefault()
    public var hover: DTButtonAppearance = DTButtonNatureHover()
    public var active: DTButtonAppearance = DTButtonNatureActive()
    public var disabled: DTButtonAppearance = DTButtonNatureDisabled()
}

private struct DTButtonNatureDefault: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "iconDefault")
    var backgroundColor: Color = .dtColor(named: "bgSurface3")
}

private struct DTButtonNatureHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "iconDefault")
    var backgroundColor: Color = .dtColor(named: "bgSurface4")
}

private struct DTButtonNatureActive: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "iconDefault")
    var backgroundColor: Color = .dtColor(named: "bgSurface5")
}

private struct DTButtonNatureDisabled: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "iconDefault").opacity(0.5)
    var backgroundColor: Color = .dtColor(named: "bgSurface3").opacity(0.5)
}

extension DTButtonStyle where Self == DTButtonNature {
    static var nature: DTButtonNature {
        DTButtonNature()
    }
}
