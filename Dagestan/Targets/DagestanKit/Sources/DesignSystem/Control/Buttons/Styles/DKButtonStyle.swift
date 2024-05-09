//
//  DKButtonStyle.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

/// Протокол `DKButtonStyle` определяет стилизацию для различных состояний кнопки.
public protocol DKButtonStyle {
    var `default`: DKButtonAppearance { get }
    var hover: DKButtonAppearance { get }
    var active: DKButtonAppearance { get }
    var disabled: DKButtonAppearance { get }
}

/// Протокол `DKButtonAppearance` описывает внешний вид кнопки, включая цвета переднего и заднего плана.
public protocol DKButtonAppearance {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}

/// Перечисление `DKButtonState` определяет возможные состояния кнопки.
public enum DKButtonState {
    case `default`
    case hover
    case active
    case disabled
}
