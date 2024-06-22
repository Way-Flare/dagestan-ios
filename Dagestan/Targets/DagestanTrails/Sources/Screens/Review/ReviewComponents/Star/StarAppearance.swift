//
//  AppearanceStar.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import Foundation

extension StarsView {
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

        var spacing: CGFloat {
            switch self {
                case .l: return Grid.pt16
                case .m: return Grid.pt10
                case .s: return Grid.pt6
            }
        }
    }
}

extension StarsView {
    enum Style: Int {
        case reviews = 5
        case review = 1
    }
}
