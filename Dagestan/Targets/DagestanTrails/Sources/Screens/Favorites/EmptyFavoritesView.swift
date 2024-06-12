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
        VStack(spacing: Grid.pt8) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Grid.pt210, height: Grid.pt210)
            Text(title)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt20))
            Text(message)
                .frame(width: Grid.pt296)
                .multilineTextAlignment(.center)
                .foregroundStyle(WFColor.foregroundSoft)
                .font(.manropeRegular(size: Grid.pt16))
        }
    }
}
