//
//  DKButtonGhost.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKButtonGhost: DKButtonStyle {
    public var `default`: DKButtonAppearance = DKButtonGhostDefault()
    public var hover: DKButtonAppearance = DKButtonGhostHover()
    public var active: DKButtonAppearance = DKButtonGhostActive()
    public var disabled: DKButtonAppearance = DKButtonGhostDisabled()
}

private struct DKButtonGhostDefault: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor
    var backgroundColor: Color = .clear
}

private struct DKButtonGhostHover: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentHover.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentContainerHover.swiftUIColor
}

private struct DKButtonGhostActive: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor
    var backgroundColor: Color = DagestanKitAsset.accentContainerActive.swiftUIColor
}

private struct DKButtonGhostDisabled: DKButtonAppearance {
    var foregroundColor: Color = DagestanKitAsset.accentDefault.swiftUIColor.opacity(0.5)
    var backgroundColor: Color = .clear
}

public extension DKButtonStyle where Self == DKButtonGhost {
    static var ghost: DKButtonGhost {
        DKButtonGhost()
    }
}
