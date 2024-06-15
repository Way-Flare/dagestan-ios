//
//  File.swift
//  
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

extension Color {
    static var random: Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
    }
}

extension String {
    // Кастомная функция для генерации стабильного хеша
    func stableHash() -> Int {
        return self.utf8.reduce(0) { (result, char) in
            result + Int(char)
        }
    }
}
