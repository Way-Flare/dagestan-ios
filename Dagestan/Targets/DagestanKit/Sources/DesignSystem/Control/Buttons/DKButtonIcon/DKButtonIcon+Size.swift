//
//  Size.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

extension DKButtonIcon {
    enum Size {
        case l
        case m
        case s
        case xs

        var cornerRadius: CGFloat {
            switch self {
                case .l, .m: return Grid.pt12
                case .s: return Grid.pt10
                case .xs: return Grid.pt8
            }
        }
        
        var padding: CGFloat {
            switch self {
                case .l: return Grid.pt14
                case .m, .s: return Grid.pt10
                case .xs: return Grid.pt6
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
