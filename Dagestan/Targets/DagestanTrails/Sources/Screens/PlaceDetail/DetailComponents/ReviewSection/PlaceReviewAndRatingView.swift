//
//  PlaceReviewAndRatingView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct PlaceReviewAndRatingView: View {
    let rating: Double
    let reviewsCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: Grid.pt12) {
            Text("Отзывы и оценки")
                .font(.manropeSemibold(size: Grid.pt18))
                .foregroundStyle(WFColor.foregroundPrimary)

            VStack(spacing: Grid.pt12) {
                RatingWingView(rating: rating, reviewsCount: reviewsCount)
                Divider()
                    .background(WFColor.borderMuted)
                    .frame(height: Grid.pt16)
                VStack(spacing: Grid.pt12) {
                    Text("Оцените место и оставьте отзыв")
                        .foregroundStyle(WFColor.iconPrimary)
                    StarsView(amount: 0, size: .l)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Grid.pt12)
            .padding(.top, Grid.pt16)
            .padding(.bottom, Grid.pt20)
            .background(WFColor.surfacePrimary)
            .cornerStyle(.constant(Grid.pt12))
        }
    }
}

#Preview {
    PlaceReviewAndRatingView(rating: 5, reviewsCount: 12)
}
