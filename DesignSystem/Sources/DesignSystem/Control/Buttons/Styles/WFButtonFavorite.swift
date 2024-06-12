//
//  WFButtonFavorite.swift
//
//  Created by Рассказов Глеб on 03.05.2024.
//

import SwiftUI

public struct WFButtonFavorite: WFButtonStyle {
    public var `default`: WFButtonAppearance = WFButtonFavoriteDefault()
    public var hover: WFButtonAppearance = WFButtonFavoriteHover()
    public var active: WFButtonAppearance = WFButtonFavoriteActive()
    public var disabled: WFButtonAppearance = WFButtonFavoriteDisabled()
}

private struct WFButtonFavoriteDefault: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.overlayPrimary
}

private struct WFButtonFavoriteHover: WFButtonAppearance {
    var foregroundColor: Color = WFColor.accentInverted
    var backgroundColor: Color = WFColor.overlaySecondary
}

private struct WFButtonFavoriteActive: WFButtonAppearance {
    var foregroundColor: Color = WFColor.errorSoft
    var backgroundColor: Color = WFColor.overlaySecondary
}

private struct WFButtonFavoriteDisabled: WFButtonAppearance {
    var foregroundColor: Color = WFColor.errorSoft
    var backgroundColor: Color = WFColor.overlayTertiary
}

public extension WFButtonStyle where Self == WFButtonFavorite {
    static var favorite: WFButtonFavorite {
        WFButtonFavorite()
    }
}
