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
    let place: Place
    let isLoading: Bool
    let onFavoriteAction: (() -> Void)?
    
    private var formatter: TimeSuffixFormatter {
        TimeSuffixFormatter(workTime: place.workTime)
    }
    
    var body: some View {
        VStack {
            imageContainerView
            contentContainerView
        }
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(Grid.pt12))
        .font(.manropeRegular(size: Grid.pt14))
    }
    
    @MainActor private var imageContainerView: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                ImageSliderView(images: place.images, canOpenFullscreen: false)
                    .frame(minHeight: Grid.pt174)
                    .cornerStyle(.constant(Grid.pt12, .topCorners))
                    .cornerStyle(.constant(Grid.pt4, .bottomCorners))
                
                WFButtonIcon(
                    icon: place.isFavorite ? DagestanTrailsAsset.heartFilled.swiftUIImage : DagestanTrailsAsset.tabHeart.swiftUIImage,
                    size: .m,
                    state: isLoading ? .loading : .default,
                    type: .favorite
                ) {
                    onFavoriteAction?()
                }
                .foregroundColor(place.isFavorite ? WFColor.errorSoft : WFColor.iconInverted)
                .padding([.top, .trailing], Grid.pt12)
            }
        }
    }
    
    private var contentContainerView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            HStack(spacing: Grid.pt12) {
                titleContainerView
                Spacer()
                starRatingView
            }
            
            operatingHoursView
            routeDescriptionView
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
            
            Text(place.name)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt16))
                .lineLimit(1)
        }
    }
    
    private var operatingHoursView: some View {
        Group {
            Text(formatter.operatingStatus.description)
                .foregroundColor(formatter.operatingStatus.descriptionColor)
            +
            Text(formatter.operatingStatus.suffix)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .foregroundStyle(WFColor.foregroundSoft)
    }
    
    @ViewBuilder private var routeDescriptionView: some View {
        if let shortDescription = place.shortDescription {
            Text(shortDescription)
                .font(.manropeRegular(size: Grid.pt14))
                .lineLimit(5)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(WFColor.foregroundPrimary)
        }
    }
    
    private var starRatingView: some View {
        HStack(spacing: Grid.pt4) {
            StarsView(amount: Int(place.rating ?? .zero), size: .s, type: .review)
            Text(String(place.rating ?? .zero))
                .font(.manropeRegular(size: Grid.pt14))
                .foregroundStyle(WFColor.foregroundSoft)
        }
    }
}
