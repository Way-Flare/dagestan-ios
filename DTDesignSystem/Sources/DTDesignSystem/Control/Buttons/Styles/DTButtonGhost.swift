//
//  DTButtonGhost.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct DTButtonGhost: DTButtonStyle {
    public var `default`: DTButtonAppearance = DTButtonGhostDefault()
    public var hover: DTButtonAppearance = DTButtonGhostHover()
    public var active: DTButtonAppearance = DTButtonGhostActive()
    public var disabled: DTButtonAppearance = DTButtonGhostDisabled()
}

private struct DTButtonGhostDefault: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentDefault")
    var backgroundColor: Color = .clear
}

private struct DTButtonGhostHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentHover")
    var backgroundColor: Color = .dtColor(named: "accentContainerHover")
}

private struct DTButtonGhostActive: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentDefault")
    var backgroundColor: Color = .dtColor(named: "accentContainerActive")
}

private struct DTButtonGhostDisabled: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "accentDefault").opacity(0.5)
    var backgroundColor: Color = .clear
}

extension DTButtonStyle where Self == DTButtonGhost {
    static var ghost: DTButtonGhost {
        DTButtonGhost()
    }
}
