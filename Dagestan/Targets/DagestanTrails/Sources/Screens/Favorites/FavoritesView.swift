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
        HStack(spacing: Grid.pt6) {
            Text("Избранное")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeExtrabold(size: Grid.pt20))
            WFCounter(style: .nature, size: .m, number: favoritesCount)
            Spacer()
        }
        .padding(.horizontal, Grid.pt12)
        .padding(.vertical, Grid.pt14)
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
