//
//  Size.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

extension DKButton {
    enum Size: String {
        case l
        case m
        case s
        case xs

        var height: CGFloat {
            switch self {
                case .l: return Grid.pt52
                case .m: return Grid.pt44
                case .s: return Grid.pt36
                case .xs: return Grid.pt28
            }
        }

        var paddings: (vertical: CGFloat, horizontal: CGFloat) {
            switch self {
                case .l: return (Grid.pt14, Grid.pt20)
                case .m, .s: return (Grid.pt10, Grid.pt20)
                case .xs: return (Grid.pt6, Grid.pt20)
            }
        }

        var cornerRadius: CGFloat {
            switch self {
                case .l, .m: return Grid.pt12
                case .s, .xs: return Grid.pt10
            }
        }

        var fontSize: CGFloat {
            switch self {
                case .l, .m: return Grid.pt16
                case .s, .xs: return Grid.pt14
            }
        }

        var imageSize: CGFloat {
            switch self {
                case .l, .m: return Grid.pt20
                case .s, .xs: return Grid.pt14
            }
        }
    }
}
