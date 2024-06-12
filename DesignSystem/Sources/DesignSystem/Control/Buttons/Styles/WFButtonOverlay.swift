//
//  WFButtonOverlay.swift
//
//  Created by Рассказов Глеб on 28.04.2024.
//

import SwiftUI

public struct WFButtonOverlay: WFButtonStyle {
    public var `default`: WFButtonAppearance = WFButtonOverlayDefault()
    public var hover: WFButtonAppearance = WFButtonOverlayHover()
    public var active: WFButtonAppearance = WFButtonOverlayActive()
    public var disabled: WFButtonAppearance = WFButtonOverlayDisabled()
}

private struct WFButtonOverlayDefault: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.overlayPrimary
}

private struct WFButtonOverlayHover: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.overlaySecondary
}

private struct WFButtonOverlayActive: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.overlayTertiary
}

private struct WFButtonOverlayDisabled: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.overlayPrimary.opacity(0.5)
}

public extension WFButtonStyle where Self == WFButtonOverlay {
    static var overlay: WFButtonOverlay {
        WFButtonOverlay()
    }
}
