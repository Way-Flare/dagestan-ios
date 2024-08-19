//
//  File.swift
//
//  Created by Abdulaev Ramazan on 07.05.2024.
//

import SwiftUI

public extension Color {
    static func dsColor(named name: String) -> Color {
        // Обращаемся к bundle модуля
        return Color(name, bundle: Bundle.module)
    }
}

public extension Color {
    func uiColor() -> UIColor {
        let components = self.components()
        return UIColor(
            red: components.red,
            green: components.green,
            blue: components.blue,
            alpha: components.alpha
        )
    }

    // swiftlint: disable large_tuple
    private func components() -> (
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat,
        alpha: CGFloat
    ) {
        let scanner = Scanner(string: description.trimmingCharacters(in: .alphanumerics))
        var hexNumber: UInt64 = 0
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            blue = CGFloat(hexNumber & 0x0000ff) / 255
            alpha = CGFloat(hexNumber & 0x000000ff) / 255
        }

        return (red, green, blue, alpha)
    }

    // swiftlint: enable large_tuple
}
