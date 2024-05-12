//
//  ManropeFont.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 23.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
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
    
    static func manropeRegular(size: CGFloat) -> Font {
        return .custom("Manrope-Regular", size: size)
    }
    
    static func manropeSemibold(size: CGFloat) -> Font {
        return .custom("Manrope-SemiBold", size: size)
    }
    
    static func manropeExtrabold(size: CGFloat) -> Font {
        return .custom("Manrope-ExtraBold", size: size)
    }
}
