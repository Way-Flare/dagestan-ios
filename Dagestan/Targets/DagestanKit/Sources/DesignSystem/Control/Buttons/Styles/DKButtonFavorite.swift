//
//  DKButtonFavorite.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 03.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKButtonFavorite: DKButtonStyle {
    public var `default`: DKButtonAppearance = DKButtonFavoriteDefault()
    public var hover: DKButtonAppearance = DKButtonFavoriteHover()
    public var active: DKButtonAppearance = DKButtonFavoriteActive()
    public var disabled: DKButtonAppearance = DKButtonFavoriteDisabled()
}

private struct DKButtonFavoriteDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay1.swiftUIColor
}

private struct DKButtonFavoriteHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay2.swiftUIColor
}

private struct DKButtonFavoriteActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.errorSoft.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay2.swiftUIColor
}

private struct DKButtonFavoriteDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.errorSoft.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay3.swiftUIColor
}

public extension DKButtonStyle where Self == DKButtonFavorite {
    static var favorite: DKButtonFavorite {
        DKButtonFavorite()
    }
}
