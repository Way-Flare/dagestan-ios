//
//  DTButtonIconStyle.swift
//
//  Created by Рассказов Глеб on 28.04.2024.
//

import SwiftUI

public struct DTButtonVisualStyle: ButtonStyle {
    let style: DTButtonStyle
    let appearance: DTButtonAppearance
    let cornerRadius: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
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
    public func buttonVisualStyle(
        style: DTButtonStyle,
        appearance: DTButtonAppearance,
        cornerRadius: CGFloat
    ) -> some View {
        self.buttonStyle(
            DTButtonVisualStyle(
                style: style,
                appearance: appearance,
                cornerRadius: cornerRadius
            )
        )
    }
}
