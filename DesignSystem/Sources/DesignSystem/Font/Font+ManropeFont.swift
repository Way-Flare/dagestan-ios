//
//  Font+ManropeFont.swift
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

public extension UIFont {
    static func manrope(weight: ManropeWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.fontName, size: size) ?? .systemFont(ofSize: size)
    }

    static func manropeRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func manropeSemibold(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Semibold", size: size) ?? .systemFont(ofSize: size)
    }

    static func manropeExtrabold(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Extrabold", size: size) ?? .systemFont(ofSize: size)
    }
}
