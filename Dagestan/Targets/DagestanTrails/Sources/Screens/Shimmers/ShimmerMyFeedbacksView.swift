//
//  ShimmerMyFeedbacksView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct ShimmerMyFeedbacksView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { _ in
                    cardView
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 12)
                }
            }
        }
        .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
        .scrollIndicators(.hidden)
    }

    private var cardView: some View {
        VStack(alignment: .leading, spacing: 12) {
            makeRectangle(width: 245, height: 24)
                .cornerStyle(.constant(4))

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    makeCircle(size: 44)

                    VStack(alignment: .leading, spacing: 4) {
                        makeRectangle(width: 53, height: 20)
                            .cornerStyle(.constant(4))

                        makeRectangle(width: 166, height: 18)
                            .cornerStyle(.constant(4))
                    }
                }

                makeRectangle(height: 196)
                    .cornerStyle(.constant(4))
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 20)
        .padding(.horizontal, 12)
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(12))
    }

    private func makeRectangle(height: CGFloat) -> some View {
        Rectangle()
            .fill()
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .skeleton()
    }

    private func makeCircle(size: CGFloat) -> some View {
        Circle()
            .fill()
            .frame(width: size, height: size)
            .skeleton()
            .cornerStyle(.round)
    }

    private func makeRectangle(width: CGFloat, height: CGFloat) -> some View {
        Rectangle()
            .fill()
            .frame(width: width, height: height)
            .skeleton()
    }
}

#Preview {
    ShimmerMyFeedbacksView()
}
