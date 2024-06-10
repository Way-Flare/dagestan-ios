//
//  ValidationRow.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct ValidationRow: View {
    var rule: ValidationRule
    
    private var foregroundColor: Color {
        if !rule.showIcon {
            return DagestanKitAsset.iconDefault.swiftUIColor
        } else {
            return rule.isValid
                   ? DagestanKitAsset.successDefault.swiftUIColor
                   : DagestanKitAsset.errorDefault.swiftUIColor
        }
    }
    
    var body: some View {
        HStack {
            rule.currentIcon
                .foregroundColor(foregroundColor)
            
            Text(rule.description)
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 14))
        }
    }
}
