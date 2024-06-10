//
//  Size.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public extension DKCounter {
    enum Size {
        case l
        case m
        case s

        var value: CGFloat {
            switch self {
                case .l: return Grid.pt32
                case .m: return Grid.pt24
                case .s: return Grid.pt16
            }
        }

        var fontSize: CGFloat {
            switch self {
                case .l, .m: return Grid.pt16
                case .s: return Grid.pt10
            }
        }
    }
}
