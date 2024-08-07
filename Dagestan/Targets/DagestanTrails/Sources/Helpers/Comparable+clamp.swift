//
//  Comparable+clamp.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

extension Comparable {
    func clamp<T: Comparable>(lower: T, upper: T) -> T {
        return min(max(self as! T, lower), upper)
    }
}
