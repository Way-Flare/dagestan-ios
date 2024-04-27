//
//  DKButtonOverlay.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 28.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonOverlay: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonSecondaryDefault()
    var hover: DKButtonAppearance = DKButtonSecondaryHover()
    var active: DKButtonAppearance = DKButtonSecondaryActive()
    var disabled: DKButtonAppearance = DKButtonSecondaryDisabled()
}

private struct DKButtonSecondaryDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconOnAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.overlayDefault.swiftUIColor
}

private struct DKButtonSecondaryHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconOnAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.overlayHover.swiftUIColor
}

private struct DKButtonSecondaryActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconOnAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.overlayActive.swiftUIColor
}

private struct DKButtonSecondaryDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.iconOnAccent.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.overlayDefault.swiftUIColor.opacity(0.5)
}

extension DKButtonStyle where Self == DKButtonOverlay {
    static var overlay: DKButtonOverlay {
        DKButtonOverlay()
    }
}
