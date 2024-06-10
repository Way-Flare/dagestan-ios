//
//  DKButtonPrimary.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKButtonPrimary: DKButtonStyle {
    public var `default`: DKButtonAppearance = DKButtonPrimaryDefault()
    public var hover: DKButtonAppearance = DKButtonPrimaryHover()
    public var active: DKButtonAppearance = DKButtonPrimaryActive()
    public var disabled: DKButtonAppearance = DKButtonPrimaryDisabled()
}

private struct DKButtonPrimaryDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor
}

private struct DKButtonPrimaryHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentHover.swiftUIColor
}

private struct DKButtonPrimaryActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentActive.swiftUIColor
}

private struct DKButtonPrimaryDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor.opacity(0.5)
}

public extension DKButtonStyle where Self == DKButtonPrimary {
    static var primary: DKButtonPrimary {
        DKButtonPrimary()
    }
}
