//
//  DTButtonOverlay.swift
//
//  Created by Рассказов Глеб on 28.04.2024.
//

import SwiftUI

public struct DTButtonOverlay: DTButtonStyle {
    public var `default`: DTButtonAppearance = DTButtonOverlayDefault()
    public var hover: DTButtonAppearance = DTButtonOverlayHover()
    public var active: DTButtonAppearance = DTButtonOverlayActive()
    public var disabled: DTButtonAppearance = DTButtonOverlayDisabled()
}

// TODO: Заменить цвета WFColor
private struct DTButtonOverlayDefault: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "on-accent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay1")
}

private struct DTButtonOverlayHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "on-accent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay2")
}

private struct DTButtonOverlayActive: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "on-accent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay3")
}

private struct DTButtonOverlayDisabled: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "on-accent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay1").opacity(0.5)
}

public extension DTButtonStyle where Self == DTButtonOverlay {
    static var overlay: DTButtonOverlay {
        DTButtonOverlay()
    }
}
