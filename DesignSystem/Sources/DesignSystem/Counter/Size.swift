//
//  Size.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import Foundation

public extension WFCounter {
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
