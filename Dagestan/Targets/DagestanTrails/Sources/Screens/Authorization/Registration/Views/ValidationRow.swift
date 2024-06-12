//
//  ValidationRow.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import SwiftUI
import DesignSystem

struct ValidationRow: View {
    var rule: ValidationRule

    private var foregroundColor: Color {
        if !rule.showIcon {
            return WFColor.iconPrimary
        } else {
            return rule.isValid
                   ? WFColor.successPrimary
                   : WFColor.errorPrimary
        }
    }

    var body: some View {
        HStack {
            rule.currentIcon
                .foregroundColor(foregroundColor)

            Text(rule.description)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt14))
        }
    }
}
