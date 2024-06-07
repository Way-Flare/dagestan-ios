//
//  ManropeFont.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 23.04.2024.
//

import SwiftUI

public enum ManropeWeight: String, CaseIterable {
    case regular = "Regular"
    case semibold = "SemiBold"
    case extrabold = "ExtraBold"
    
    var fontName: String {
        return "Manrope-\(self.rawValue)"
    }
}

public extension Font {
    static func manrope(weight: ManropeWeight, size: CGFloat) -> Font {
        return .custom(weight.fontName, size: size)
    }
}
