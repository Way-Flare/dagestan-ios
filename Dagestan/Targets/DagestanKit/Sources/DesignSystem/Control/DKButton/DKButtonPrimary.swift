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
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonPrimaryHover: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonPrimaryActive: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonPrimaryDisabled: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

extension DKButtonStyle where Self == DKButtonPrimary {
    static var primary: DKButtonPrimary {
        DKButtonPrimary()
    }
}
