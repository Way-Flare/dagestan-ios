//
//  DKButtonFavorite.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 03.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonFavorite: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonFavoriteDefault()
    var hover: DKButtonAppearance = DKButtonFavoriteHover()
    var active: DKButtonAppearance = DKButtonFavoriteActive()
    var disabled: DKButtonAppearance = DKButtonFavoriteDisabled()
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

extension DKButtonStyle where Self == DKButtonFavorite {
    static var favorite: DKButtonFavorite {
        DKButtonFavorite()
    }
}
