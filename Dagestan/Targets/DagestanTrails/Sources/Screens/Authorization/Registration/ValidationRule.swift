//
//  ValidationRule.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import SwiftUI

struct ValidationRule {
    var description: String
    var isValid: Bool
    var showIcon: Bool
    var correctIcon: Image

    var currentIcon: Image {
        !showIcon ? correctIcon : (isValid ? correctIcon : Image(systemName: "questionmark"))
    }

    init(
        description: String,
        isValid: Bool,
        correctIcon: Image,
        showIcon: Bool = true
    ) {
        self.description = description
        self.isValid = isValid
        self.correctIcon = correctIcon
        self.showIcon = showIcon
    }
}
