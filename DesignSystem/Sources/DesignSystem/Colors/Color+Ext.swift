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
