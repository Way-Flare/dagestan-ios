//
//  ValidationRule.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct ValidationRule {
    var description: String
    var isValid: Bool
    var showIcon: Bool
    var correctIcon: Image
    
    var currentIcon: Image {
        !showIcon ? correctIcon : (isValid ? correctIcon : DagestanKitAsset.essentialWarning2Bulk.swiftUIImage)
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
