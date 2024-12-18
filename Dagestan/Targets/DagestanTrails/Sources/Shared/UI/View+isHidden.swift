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
    func setCustomBackButton(
        placement: ToolbarItemPlacement = .navigationBarLeading,
        content: () -> some View = { BackButton() }
    ) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: placement) {
                    content()
                }
            }
    }
}

extension View {
    func setCustomNavigationBarTitle(title: String) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.manropeExtrabold(size: Grid.pt20))
                        .foregroundColor(WFColor.foregroundPrimary)
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
