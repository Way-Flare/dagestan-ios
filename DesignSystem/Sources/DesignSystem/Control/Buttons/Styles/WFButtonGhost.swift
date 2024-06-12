//
//  WFButtonGhost.swift
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import SwiftUI

public struct WFButtonGhost: WFButtonStyle {
    public var `default`: WFButtonAppearance = WFButtonGhostDefault()
    public var hover: WFButtonAppearance = WFButtonGhostHover()
    public var active: WFButtonAppearance = WFButtonGhostActive()
    public var disabled: WFButtonAppearance = WFButtonGhostDisabled()
    
    public init() { }
}

private struct WFButtonGhostDefault: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = .clear
}

private struct WFButtonGhostHover: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentHover
    var backgroundColor: Color = WFColor.accentContainerHover
}

private struct WFButtonGhostActive: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary
    var backgroundColor: Color = WFColor.accentContainerActive
}

private struct WFButtonGhostDisabled: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentPrimary.opacity(0.5)
    var backgroundColor: Color = .clear
}

public extension WFButtonStyle where Self == WFButtonGhost {
    static var ghost: WFButtonGhost {
        WFButtonGhost()
    }
}
