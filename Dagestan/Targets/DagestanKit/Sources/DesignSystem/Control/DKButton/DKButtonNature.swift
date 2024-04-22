//
//  DKButtonNature.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonNature: DKButtonStyle {
    var `default`: DKButtonAppearance = DKButtonNatureDefault()
    var hover: DKButtonAppearance = DKButtonNatureHover()
    var active: DKButtonAppearance = DKButtonNatureActive()
    var disabled: DKButtonAppearance = DKButtonNatureDisabled()
}

private struct DKButtonNatureDefault: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonNatureHover: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonNatureActive: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

private struct DKButtonNatureDisabled: DKButtonAppearance {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .black
}

extension DKButtonStyle where Self == DKButtonNature {
    static var nature: DKButtonNature {
        DKButtonNature()
    }
}
