//
//  String+Ext.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

extension String {
    // Кастомная функция для генерации стабильного хеша
    func stableHash() -> Int {
        return self.utf8.reduce(0) { (result, char) in
            result + Int(char)
        }
    }
}
