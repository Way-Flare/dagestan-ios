//
//  FavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import DesignSystem
import SwiftUI

struct FavoritesView: View {
    @State var section: FavoriteSection = .places
    let favoritesCount = 5

    var body: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack(spacing: Grid.pt12) {
                counterContainerView
                if favoritesCount == 0 {
                    Spacer()
                    emptyStateContainerView
                    Spacer()
                    Spacer()
                } else {
                    WFSegmentedPickerView(selection: $section) { section in
                        contentView(for: section)
                    }
                }
                WFAvatarView.initials("Gleb Rasskazov", userId: "36152", size: .size88)
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

    @ViewBuilder
    private func contentView(for section: FavoriteSection) -> some View {
        ScrollView {
            switch section {
                case .places, .routes:
                    LazyVStack(spacing: Grid.pt12) {
                        ForEach(0 ..< favoritesCount, id: \.self) { _ in
                            FavoriteCardView()
                                .padding(.horizontal, Grid.pt12)
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FavoritesView()
}
