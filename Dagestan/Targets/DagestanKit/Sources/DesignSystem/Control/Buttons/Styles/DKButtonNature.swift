//
//  DKButtonNature.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKButtonNature: DKButtonStyle {
    public var `default`: DKButtonAppearance = DKButtonNatureDefault()
    public var hover: DKButtonAppearance = DKButtonNatureHover()
    public var active: DKButtonAppearance = DKButtonNatureActive()
    public var disabled: DKButtonAppearance = DKButtonNatureDisabled()
}

private struct DKButtonNatureDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgSurface3.swiftUIColor
}

private struct DKButtonNatureHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgSurface4.swiftUIColor
}

private struct DKButtonNatureActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgSurface5.swiftUIColor
}

private struct DKButtonNatureDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconDefault.swiftUIColor.opacity(0.5)
    var backgroundColor: Color = DagestanKitAsset.bgSurface3.swiftUIColor.opacity(0.5)
}

public extension DKButtonStyle where Self == DKButtonNature {
    static var nature: DKButtonNature {
        DKButtonNature()
    }
}
