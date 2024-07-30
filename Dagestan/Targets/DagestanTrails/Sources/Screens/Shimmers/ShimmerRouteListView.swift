//
//  ShimmerRouteListView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 30.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct ShimmerRouteListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(0 ..< 5, id: \.self) { _ in
                    cardView
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    private var cardView: some View {
        VStack(spacing: .zero) {
            makeRectangle(height: 174)
                .cornerStyle(.constant(12, .topCorners))
                .cornerStyle(.constant(4, .bottomCorners))

            VStack(alignment: .leading, spacing: 6) {
                makeRectangle(height: 24)
                    .cornerStyle(.constant(4))
                makeRectangle(width: 179, height: 16)
                    .cornerStyle(.constant(4))
                makeRectangle(height: 48)
                    .cornerStyle(.constant(4))
            }
            .padding(8)
            .background(WFColor.surfacePrimary)
            .cornerStyle(.constant(12, .bottomCorners))
        }
        .padding(.horizontal, 12)
    }

    private func makeRectangle(height: CGFloat) -> some View {
        Rectangle()
            .fill()
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .skeleton()
    }

    private func makeRectangle(width: CGFloat, height: CGFloat) -> some View {
        Rectangle()
            .fill()
            .frame(width: width, height: height)
            .skeleton()
    }
}

#Preview {
    ShimmerRouteListView()
}
