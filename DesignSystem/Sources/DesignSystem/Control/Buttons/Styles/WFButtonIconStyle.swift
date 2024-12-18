//
//  WFButtonVisualStyle.swift
//
//  Created by Рассказов Глеб on 28.04.2024.
//

import SwiftUI

public struct WFButtonVisualStyle: ButtonStyle {
    public let style: WFButtonStyle
    public let appearance: WFButtonAppearance
    public let cornerRadius: CGFloat
    public let foregroundColor: Color?
    
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
        isPressed ? style.active.foregroundColor : foregroundColor ?? appearance.foregroundColor
    }
}

public extension View {
    func buttonVisualStyle(
        style: WFButtonStyle,
        appearance: WFButtonAppearance,
        cornerRadius: CGFloat,
        foregroundColor: Color? = nil
    ) -> some View {
        self.buttonStyle(
            WFButtonVisualStyle(
                style: style,
                appearance: appearance,
                cornerRadius: cornerRadius,
                foregroundColor: foregroundColor
            )
        )
    }
}
