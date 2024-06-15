//
//  WFButtonIcon+Size.swift
//  CoreKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import Foundation

public extension WFButtonIcon {
    /// Перечисление `Size` определяет размеры для пользовательского элемента `WFButtonIcon`.
    enum Size {
        /// Большой размер.
        case l
        /// Средний размер.
        case m
        /// Маленький размер.
        case s
        /// Очень маленький размер.
        case xs

        /// Радиус скругления углов в зависимости от размера кнопки.
        var cornerRadius: CGFloat {
            switch self {
                case .l, .m: return Grid.pt12
                case .s: return Grid.pt10
                case .xs: return Grid.pt8
            }
        }

        /// Отступы в зависимости от размера кнопки.
        var padding: CGFloat {
            switch self {
                case .l: return Grid.pt14
                case .m, .s: return Grid.pt10
                case .xs: return Grid.pt6
            }
        }

        /// Размер изображения в зависимости от размера кнопки.
        var imageSize: CGFloat {
            switch self {
                case .l, .m: return Grid.pt20
                case .s, .xs: return Grid.pt14
            }
        }
    }
}
