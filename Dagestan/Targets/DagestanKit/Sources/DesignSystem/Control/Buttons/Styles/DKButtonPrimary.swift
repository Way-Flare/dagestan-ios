//
//  DKButtonPrimary.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonPrimary: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonPrimaryDefault()
    var hover: DKButtonAppearance = DKButtonPrimaryHover()
    var active: DKButtonAppearance = DKButtonPrimaryActive()
    var disabled: DKButtonAppearance = DKButtonPrimaryDisabled()
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

extension DKButtonStyle where Self == DKButtonPrimary {
    static var primary: DKButtonPrimary {
        DKButtonPrimary()
    }
}
