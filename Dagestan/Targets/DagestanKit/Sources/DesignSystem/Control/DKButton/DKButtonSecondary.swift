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
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonSecondaryHover: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonSecondaryActive: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonSecondaryDisabled: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

extension DKButtonStyle where Self == DKButtonSecondary {
    static var secondary: DKButtonSecondary {
        DKButtonSecondary()
    }
}
