//
//  FavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct FavoritesView: View {
    let favoritesCount = 0
    
    var body: some View {
        ZStack {
            DagestanKitAsset.bgSurface2.swiftUIColor.ignoresSafeArea()
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
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.extraBold.swiftUIFont(size: 20))
            DKCounter(style: .nature, size: .m, number: favoritesCount)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
    }
    
    private var emptyStateContainerView: some View {
        StateFavoritesView(
            image: DagestanKitAsset.emptyFavorites.swiftUIImage,
            title: "Сейчас тут пусто",
            message: "Мы покажем тут места и маршруты, которые ты добавишь в избранное"
        )
    }
    
    private var connectionStateContainerView: some View {
        StateFavoritesView(
            image: DagestanKitAsset.connectionFavorites.swiftUIImage,
            title: "Плохое соеденение",
            message: "Проверь доступ к интернету и обнови страницу"
        )
    }
}

#Preview {
    FavoritesView()
}
