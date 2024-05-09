//
//  SkeletonViewModifierPrimary.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct SkeletonModifier: ViewModifier {
    @State private var isAnimating = false
    private let foreverAnimation = Animation.default.speed(0.25).repeatForever(autoreverses: false)
    private let isLoading: Bool
    private let cornerStyle: CornerStyle
    
    init(isLoading: Bool, cornerStyle: CornerStyle) {
        self.isLoading = isLoading
        self.cornerStyle = cornerStyle
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .disabled(isLoading)
            .overlay(
                GeometryReader { geo in
                    let width = geo.size.width
                    let xOffset = isAnimating ? width : -width
                    skeletonIfNeeded(
                        gradientOffset: xOffset,
                        height: geo.size.height
                    )
                }
            )
            .animation(.default, value: isLoading)
    }
    
    @ViewBuilder
    private func skeletonIfNeeded(
        gradientOffset: CGFloat,
        height: CGFloat
    ) -> some View {
        if isLoading {
            ZStack {
                DagestanKitAsset.bgSurface4.swiftUIColor
                    .overlay(
                        Color.white
                            .mask(
                                Rectangle()
                                    .fill(linearGradient)
                                    .offset(x: gradientOffset)
                            )
                            .animation(foreverAnimation, value: isAnimating)
                    )
                    .cornerStyle(cornerStyle)
                    .onAppear { isAnimating = true }
                    .onDisappear { isAnimating = false }
            }
        } else {
            EmptyView()
        }
    }
    
    private var linearGradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [.clear, .white, .clear]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
