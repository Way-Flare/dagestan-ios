//
//  DKButtonSecondary.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonSecondary: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonSecondaryDefault()
    var hover: DKButtonAppearance = DKButtonSecondaryHover()
    var active: DKButtonAppearance = DKButtonSecondaryActive()
    var disabled: DKButtonAppearance = DKButtonSecondaryDisabled()
}

private struct DKButtonSecondaryDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentContainerDefault.swiftUIColor
}

private struct DKButtonSecondaryHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentContainerHover.swiftUIColor
}

private struct DKButtonSecondaryActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentContainerActive.swiftUIColor
}

private struct DKButtonSecondaryDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor.opacity(0.5)
    var backgroundColor: Color = DagestanKitAsset.accentContainerDefault.swiftUIColor.opacity(0.5)
}

extension DKButtonStyle where Self == DKButtonSecondary {
    static var secondary: DKButtonSecondary {
        DKButtonSecondary()
    }
}
