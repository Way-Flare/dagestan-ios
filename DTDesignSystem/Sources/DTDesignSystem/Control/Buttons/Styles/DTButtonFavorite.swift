//
//  DTButtonFavorite.swift
//
//  Created by Рассказов Глеб on 03.05.2024.
//

import SwiftUI

public struct DTButtonFavorite: DTButtonStyle {
    public var `default`: DTButtonAppearance = DTButtonFavoriteDefault()
    public var hover: DTButtonAppearance = DTButtonFavoriteHover()
    public var active: DTButtonAppearance = DTButtonFavoriteActive()
    public var disabled: DTButtonAppearance = DTButtonFavoriteDisabled()
}

// TODO: Заменить цвета WFColor
private struct DTButtonFavoriteDefault: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "on-accent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay1")
}

private struct DTButtonFavoriteHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "on-accent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay2")
}

private struct DTButtonFavoriteActive: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "errorSoft")
    var backgroundColor: Color = .dtColor(named: "bgOverlay2")
}

private struct DTButtonFavoriteDisabled: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "errorSoft")
    var backgroundColor: Color = .dtColor(named: "bgOverlay3")
}

public extension DTButtonStyle where Self == DTButtonFavorite {
    static var favorite: DTButtonFavorite {
        DTButtonFavorite()
    }
}
