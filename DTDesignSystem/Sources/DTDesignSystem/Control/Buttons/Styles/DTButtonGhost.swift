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
    
    public init() { }
}

private struct DTButtonGhostDefault: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = .clear
}

private struct DTButtonGhostHover: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentHover
    var backgroundColor: Color = WFColor.accentContainerHover
}

private struct DTButtonGhostActive: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerActive
}

private struct DTButtonGhostDisabled: DTButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary.opacity(0.5)
    var backgroundColor: Color = .clear
}

public extension DTButtonStyle where Self == DTButtonGhost {
    static var ghost: DTButtonGhost {
        DTButtonGhost()
    }
}
