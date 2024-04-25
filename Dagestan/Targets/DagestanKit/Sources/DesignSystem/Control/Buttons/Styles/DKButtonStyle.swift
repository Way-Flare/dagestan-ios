//
//  DKButtonStyle.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

protocol DKButtonStyle {
    var `default`: DKButtonAppearance { get }
    var hover: DKButtonAppearance { get }
    var active: DKButtonAppearance { get }
    var disabled: DKButtonAppearance { get }
}

enum DKButtonState: String {
    case `default`
    case hover
    case active
    case disabled
}

protocol DKButtonAppearance {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}
