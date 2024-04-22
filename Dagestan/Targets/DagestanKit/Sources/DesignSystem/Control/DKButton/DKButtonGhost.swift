//
//  DKButtonGhost.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonGhost: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonGhostDefault()
    var hover: DKButtonAppearance = DKButtonGhostHover()
    var active: DKButtonAppearance = DKButtonGhostActive()
    var disabled: DKButtonAppearance = DKButtonGhostDisabled()
}

private struct DKButtonGhostDefault: DKButtonAppearance {
    var foregroundColor: Color = .white.opacity(0.1)
    var backgroundColor: Color = .black.opacity(0.7)
}

private struct DKButtonGhostHover: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonGhostActive: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonGhostDisabled: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

extension DKButtonStyle where Self == DKButtonGhost {
    static var ghost: DKButtonGhost {
        DKButtonGhost()
    }
}
