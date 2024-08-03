//
//  DSPressedButtonStyle.swift
//
//  Created by Ramazan Abdulaev on 01.08.2024.
//

import SwiftUI

/// Притивный стиль кнопки, анимирующее нажатие путем изменения размера
public struct DSPressedButtonStyle: PrimitiveButtonStyle {
    @State private var isPressed = false
    @State private var viewFrame: CGRect = .zero
    private let isCancellable: Bool

    /// Инициализатор
    /// - Parameter isCancellable: Можно ли отменить нажатие
    public init(isCancellable: Bool = true) {
        self.isCancellable = isCancellable
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: isPressed)
            .background(
                GeometryReader { innerGeometry in
                    Color.clear.onAppear {
                        viewFrame = innerGeometry.frame(in: .local)
                    }
                }
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation {
                            isPressed = true
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            isPressed = false
                            if !isCancellable || (isCancellable && viewFrame.contains(value.location)) {
                                configuration.trigger()
                            }
                        }
                    }
            )
    }
}
