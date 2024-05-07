//
//  DTButtonStyle.swift
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

/// Протокол `DTButtonStyle` определяет стилизацию для различных состояний кнопки.
public protocol DTButtonStyle {
    var `default`: DTButtonAppearance { get }
    var hover: DTButtonAppearance { get }
    var active: DTButtonAppearance { get }
    var disabled: DTButtonAppearance { get }
}

/// Перечисление `DTButtonState` определяет возможные состояния кнопки.
public enum DTButtonState {
    case `default`
    case hover
    case active
    case disabled
}

/// Протокол `DTButtonAppearance` описывает внешний вид кнопки, включая цвета переднего и заднего плана.
public protocol DTButtonAppearance {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}
