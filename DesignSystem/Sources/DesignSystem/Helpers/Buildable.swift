//
//  Buildable.swift
//
//  Created by Рассказов Глеб on 20.05.2024.
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
