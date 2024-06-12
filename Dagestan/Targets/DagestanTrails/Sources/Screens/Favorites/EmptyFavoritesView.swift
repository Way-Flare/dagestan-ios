//
//  EmptyFavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import SwiftUI
import DesignSystem

struct StateFavoritesView: View {
    let image: Image
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 8) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210, height: 210)
            Text(title)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: 20))
            Text(message)
                .frame(width: 296)
                .multilineTextAlignment(.center)
                .foregroundStyle(WFColor.foregroundSoft)
                .font(.manropeRegular(size: 16))
        }
    }
}
