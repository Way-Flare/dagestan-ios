//
//  View+isHidden.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 01.06.2024.
//

import SwiftUI
import DesignSystem

extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if !hidden {
            self
        }
    }
}

extension View {
    func setBorder(
        radius: CGFloat = 8,
        width: CGFloat = 0.5,
        color: Color = WFColor.borderMuted
    ) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: width)
            )
    }
}

extension View {
    func setCustomBackButton() -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
    }
}

extension View {
    func placeholder(when show: Bool, with text: String) -> some View {
        overlay(
            Group {
                if show {
                    Text(text)
                        .foregroundColor(WFColor.foregroundSoft)
                        .allowsHitTesting(false)
                }
            },
            alignment: .leading
        )
    }
}
