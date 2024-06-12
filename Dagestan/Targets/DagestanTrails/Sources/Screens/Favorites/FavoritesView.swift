//
//  FavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import SwiftUI
import DesignSystem

struct FavoritesView: View {
    let favoritesCount = 0

    var body: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack {
                counterContainerView
                Spacer()
                counterContainerView
                Spacer()
            }
        }
    }

    private var counterContainerView: some View {
        HStack(spacing: 6) {
            Text("Избранное")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeExtrabold(size: 20))
            WFCounter(style: .nature, size: .m, number: favoritesCount)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
    }

    private var emptyStateContainerView: some View {
        StateFavoritesView(
            image: DagestanTrailsAsset.emptyFavorites.swiftUIImage,
            title: "Сейчас тут пусто",
            message: "Мы покажем тут места и маршруты, которые ты добавишь в избранное"
        )
    }

    private var connectionStateContainerView: some View {
        StateFavoritesView(
            image: DagestanTrailsAsset.connectionFavorites.swiftUIImage,
            title: "Плохое соеденение",
            message: "Проверь доступ к интернету и обнови страницу"
        )
    }
}

#Preview {
    FavoritesView()
}
