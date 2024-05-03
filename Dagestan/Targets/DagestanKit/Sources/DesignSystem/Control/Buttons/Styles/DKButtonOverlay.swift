//
//  DKButtonOverlay.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 28.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonOverlay: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonOverlayDefault()
    var hover: DKButtonAppearance = DKButtonOverlayHover()
    var active: DKButtonAppearance = DKButtonOverlayActive()
    var disabled: DKButtonAppearance = DKButtonOverlayDisabled()
}

private struct DKButtonOverlayDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay1.swiftUIColor
}

private struct DKButtonOverlayHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay2.swiftUIColor
}

private struct DKButtonOverlayActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay3.swiftUIColor
}

private struct DKButtonOverlayDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.onAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.bgOverlay1.swiftUIColor.opacity(0.5)
}

extension DKButtonStyle where Self == DKButtonOverlay {
    static var overlay: DKButtonOverlay {
        DKButtonOverlay()
    }
}
