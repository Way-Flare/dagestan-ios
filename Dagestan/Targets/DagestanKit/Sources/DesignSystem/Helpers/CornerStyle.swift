//
//  CornerStyle.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import UIKit

public enum CornerStyle {
    case round
    case constant(
        CGFloat,
        CACornerMask = .all
    )

    public static var none: CornerStyle {
        .constant(0)
    }
}

public extension CACornerMask {
    static var all: CACornerMask {
        [
            topCorners,
            bottomCorners
        ]
    }
    
    static var topCorners: CACornerMask {
        [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }
    
    static var bottomCorners: CACornerMask {
        [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
    }
    
}
