//
//  FavoriteCardView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct FavoriteCardView: View {
    var body: some View {
        VStack {
            imageContainerView
            contentContainerView
        }
        .background(.white)
        .cornerStyle(.constant(Grid.pt12, .bottomCorners))
        .font(.manropeRegular(size: Grid.pt14))
    }
    
    private var imageContainerView: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image("phoot")
                    .resizable()
                    .frame(height: Grid.pt174)
                    .cornerStyle(.constant(Grid.pt12, .topCorners))
                    .cornerStyle(.constant(Grid.pt4, .bottomCorners))
                
                WFButtonIcon(
                    icon: DagestanTrailsAsset.heartFilled.swiftUIImage,
                    size: .m,
                    type: .favorite
                ) {}
                    .foregroundColor(WFColor.errorSoft)
                    .padding([.top, .trailing], Grid.pt12)
            }
        }
    }
    
    private var contentContainerView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            HStack(spacing: Grid.pt12) {
                titleContainerView
                ratingContainerView
            }
            
            Text("Открыто • до 21:00")
                .foregroundStyle(WFColor.foregroundSoft)

            Text("Маршрут 'Дагестанский квест': Погрузитесь в магию Дагестана, начав магию Дагестана, начав магию Дагестана, начав магию ")
                .foregroundStyle(WFColor.iconPrimary)
        }
        .padding([.top, .horizontal], Grid.pt8)
        .padding(.bottom, Grid.pt12)
    }
    
    private var titleContainerView: some View {
        HStack(spacing: Grid.pt4) {
            DagestanTrailsAsset.tree.swiftUIImage
                .resizable()
                .frame(width: Grid.pt20, height: Grid.pt20)
                .foregroundStyle(WFColor.iconSoft)
            
            Text("Склон горы Тарки-Тау  Смотровая площадка")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt16))
                .lineLimit(1)
        }
    }
    
    private var ratingContainerView: some View {
        HStack(spacing: Grid.pt4) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: Grid.pt16, height: Grid.pt16)
                .foregroundStyle(.yellow)
            
            Text("4.3")
                .foregroundStyle(WFColor.foregroundSoft)
        }
    }
}

#Preview {
    FavoriteCardView()
        .padding(.horizontal, Grid.pt12)
}
