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

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
