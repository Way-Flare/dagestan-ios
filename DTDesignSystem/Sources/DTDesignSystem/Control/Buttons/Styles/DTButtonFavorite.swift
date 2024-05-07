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

private struct DTButtonFavoriteDefault: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "onAccent")
    var backgroundColor: Color = .dtColor(named: "bgOverlay1")
}

private struct DTButtonFavoriteHover: DTButtonAppearance {
    var foregroundColor: Color = .dtColor(named: "onAccent")
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

extension DTButtonStyle where Self == DTButtonFavorite {
    static var favorite: DTButtonFavorite {
        DTButtonFavorite()
    }
}
