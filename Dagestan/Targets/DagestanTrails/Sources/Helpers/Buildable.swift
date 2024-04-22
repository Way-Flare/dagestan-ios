//
//  Buildable.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

protocol Buildable {
    func map(_ closure: (inout Self) -> Void) -> Self
}

extension Buildable {
    func map(_ closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
