//
//  View+Ext.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 27.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct MapFloatingButtonStyle: ButtonStyle {
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let opacity = configuration.isPressed ? 0.8 : 1
        configuration.label
            .frame(width: 40, height: 40)
            .floating(Circle())
            .animation(.easeIn, value: opacity)
            .opacity(opacity)
    }
}

@available(iOS 14.0, *)
struct FloatingStyle <S: Shape>: ViewModifier {
    var padding: CGFloat
    var shape: S
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .regularMaterialBackground()
            .clipShape(shape)
            .shadow(radius: 1.4, y: 0.7)
            .padding(5)
    }
}

@available(iOS 13.0, *)
extension View {
    @ViewBuilder
    /// Material фон
    func regularMaterialBackground() -> some View {
        if #available(iOS 15.0, *) {
            self.background(.regularMaterial)
        } else {
            self.background(Color(UIColor.systemBackground))
        }
    }
}

@available(iOS 14.0, *)
extension View {
    func floating<S>(padding: CGFloat = 5, _ shape: S) -> some View where S: Shape {
        modifier(FloatingStyle(padding: padding, shape: shape))
    }

    func floating(padding: CGFloat = 5) -> some View {
        floating(padding: padding, RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
    }
}
extension View {
    func limitPaneWidth() -> some View {
        self.frame(maxWidth: 500)
    }

    func fixedMenuOrder() -> some View {
        if #available(iOS 16.0, *) {
            return self.menuOrder(.fixed)
        } else {
            return AnyView(self)
        }
    }
}

@available(iOS 13.0, *)
extension View {
    func safeContentTransition() -> some View {
        if #available(iOS 17, *) {
            return self.contentTransition(.symbolEffect(.replace))
        }
        return self
    }
}
