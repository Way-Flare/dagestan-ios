//
//  DTButton+Size.swift
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public extension DTButton {
    /// Перечисление `Size` определяет размеры для пользовательского элемента `DTButton`.
    enum Size {
        /// Большой размер.
        case l
        /// Средний размер.
        case m
        /// Маленький размер.
        case s
        /// Очень маленький размер.
        case xs

        /// Высота кнопки в зависимости от размера кнопки.
        var height: CGFloat {
            switch self {
                case .l: return Grid.pt52
                case .m: return Grid.pt44
                case .s: return Grid.pt36
                case .xs: return Grid.pt28
            }
        }

        /// Горизонтальные отступы в зависимости от размера кнопки.
        var horizontalPadding: CGFloat {
            switch self {
                case .l: return Grid.pt14
                case .m, .s: return Grid.pt10
                case .xs: return Grid.pt6
            }
        }

        /// Радиус скругления углов в зависимости от размера кнопки.
        var cornerRadius: CGFloat {
            switch self {
                case .l, .m: return Grid.pt12
                case .s, .xs: return Grid.pt10
            }
        }

        /// Размер шрифта в зависимости от размера кнопки.
        var fontSize: CGFloat {
            switch self {
                case .l, .m: return Grid.pt16
                case .s, .xs: return Grid.pt14
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
