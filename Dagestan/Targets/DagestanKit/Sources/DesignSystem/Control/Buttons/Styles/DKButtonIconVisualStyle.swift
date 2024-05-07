//
//  DKButtonIconStyle.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 28.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonVisualStyle: ButtonStyle {
    let style: DKButtonStyle
    let appearance: DKButtonAppearance
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(configureForegroundColor(isPressed: configuration.isPressed))
            .background(configureBackgroundColor(isPressed: configuration.isPressed))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    private func configureBackgroundColor(isPressed: Bool) -> Color {
        isPressed ? style.active.backgroundColor : appearance.backgroundColor
    }
    
    private func configureForegroundColor(isPressed: Bool) -> Color {
        isPressed ? style.active.foregroundColor : appearance.foregroundColor
    }
}

extension View {
    func buttonVisualStyle(
        style: DKButtonStyle,
        appearance: DKButtonAppearance,
        cornerRadius: CGFloat
    ) -> some View {
        self.buttonStyle(
            DKButtonVisualStyle(
                style: style,
                appearance: appearance,
                cornerRadius: cornerRadius
            )
        )
    }
}
