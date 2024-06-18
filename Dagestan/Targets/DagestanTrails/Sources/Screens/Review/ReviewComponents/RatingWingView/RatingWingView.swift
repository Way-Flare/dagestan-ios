//
//  RatingWingView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct RatingWingView: View {
    let rating: Double
    let reviewsCount: Int
    
    // TODO: DAGESTAN-200
    private var reviewString: String {
        if reviewsCount > 0 {
            return "Всего \(reviewsCount) \(correctFormForCount(reviewsCount))"
        }
        return "Нет отзывов"
    }
    
    var body: some View {
        HStack(spacing: Grid.pt24) {
            DagestanTrailsAsset.wingLeft.swiftUIImage
                .resizable()
                .frame(width: Grid.pt49, height: Grid.pt83)
            ratingContentView
            DagestanTrailsAsset.wingRight.swiftUIImage
                .resizable()
                .frame(width: Grid.pt49, height: Grid.pt83)
        }
        .padding(.horizontal, Grid.pt21)
    }
    
    private var ratingContentView: some View {
        VStack(spacing: Grid.pt4) {
            Text(String(rating))
                .font(.manropeSemibold(size: Grid.pt48))
            Text(reviewString)
                .font(.manropeRegular(size: Grid.pt14))
        }
        .frame(width: Grid.pt125)
        .foregroundStyle(WFColor.iconPrimary)
    }
    
    // TODO: DAGESTAN-200
    private func correctFormForCount(_ count: Int) -> String { // Потом придумаю как сделать сущность которая будет учитывать плюрализацию
        let lastDigit = count % 10
        let lastTwoDigits = count % 100

        if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
            return "отзывов"
        } else if lastDigit == 1 {
            return "отзыв"
        } else if lastDigit >= 2 && lastDigit <= 4 {
            return "отзыва"
        } else {
            return "отзывов"
        }
    }
}

#Preview {
    RatingWingView(rating: 5, reviewsCount: 10421)
}
