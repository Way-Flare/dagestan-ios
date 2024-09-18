//
//  RouteCardView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

@MainActor
struct RouteCardView: View {
    @State var showAlert = false
    @AppStorage("isAuthorized") var isAuthorized = false
    let route: Route
    let isLoading: Bool
    let onFavoriteAction: (() -> Void)?











    var body: some View {
        VStack(alignment: .leading) {
            imageContainerView
            contentContainerView
        }
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(Grid.pt12))
        .font(.manropeRegular(size: Grid.pt14))
    }

    private var imageContainerView: some View {
        ZStack(alignment: .topTrailing) {
            ImageSliderView(images: route.images, canOpenFullscreen: false)
                .frame(minHeight: Grid.pt174)
                .clipped()

            WFButtonIcon(
                icon: route.isFavorite ? DagestanTrailsAsset.heartFilled.swiftUIImage : DagestanTrailsAsset.tabHeart.swiftUIImage,
                size: .m,
                state: isLoading ? .loading : .default,
                type: .favorite
            ) {
                guard isAuthorized else {
                    showAlert = true
                    return
                }
                onFavoriteAction?()
            }
            .foregroundColor(route.isFavorite ? WFColor.errorSoft : WFColor.iconInverted)
            .padding([.top, .trailing], Grid.pt12)
            .notAuthorizedAlert(isPresented: $showAlert)
        }
    }

    private var contentContainerView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            HStack(spacing: Grid.pt12) {
                titleContainerView
                Spacer()
                ratingContainerView
            }

            Text("\(String(format: "%.2f", route.distance)) км • \(formatExtendedTravelTime()) • \(route.placesCount) мест")
                .foregroundStyle(WFColor.foregroundSoft)

            Text(route.shortDescription ?? "")
                .multilineTextAlignment(.leading)
                .foregroundStyle(WFColor.iconPrimary)
        }
        .padding([.top, .horizontal], Grid.pt8)
        .padding(.bottom, Grid.pt12)
    }

    private var titleContainerView: some View {
        Text(route.title)
            .foregroundStyle(WFColor.foregroundPrimary)
            .font(.manropeSemibold(size: Grid.pt16))
            .lineLimit(1)
    }

    private var ratingContainerView: some View {
        HStack(spacing: Grid.pt4) {
            StarsView(amount: 1, size: .s, type: .review)
            Text(String(format: "%.1f", route.rating))
                .foregroundStyle(WFColor.foregroundSoft)
        }
    }

    private func formatExtendedTravelTime() -> String {
        let components = route.travelTime.split(separator: ":").map { Int($0) ?? 0 }

        if components.count == 3 {
            var hours = components[0]
            let minutes = components[1]

            let days = hours / 24
            hours %= 24

            var result = ""
            if days > 0 {
                result += "\(days)дн "
            }
            if hours > 0 || days > 0 {
                result += "\(hours)ч "
            }
            result += "\(minutes)мин"

            return result
        }

        return ""
    }
}
