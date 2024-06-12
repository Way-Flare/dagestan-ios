//
//  WFButtonStyle.swift
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

/// Протокол `WFButtonStyle` определяет стилизацию для различных состояний кнопки.
public protocol WFButtonStyle {
    var `default`: WFButtonAppearance { get }
    var hover: WFButtonAppearance { get }
    var active: WFButtonAppearance { get }
    var disabled: WFButtonAppearance { get }
}

/// Перечисление `WFButtonState` определяет возможные состояния кнопки.
public enum WFButtonState {
    case `default`
    case hover
    case active
    case disabled
}

/// Протокол `WFButtonAppearance` описывает внешний вид кнопки, включая цвета переднего и заднего плана.
public protocol WFButtonAppearance {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
}
