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
    let route: Route
    
    var body: some View {
        VStack(alignment: .leading) {
            imageContainerView
            contentContainerView
        }
        .background(.white)
        .cornerStyle(.constant(Grid.pt12))
        .font(.manropeRegular(size: 14))
    }
    
    private var imageContainerView: some View {
        ZStack(alignment: .topTrailing) {
            SliderView(images: route.images)
                .frame(height: 174)
                
            WFButtonIcon(
                icon: DagestanTrailsAsset.heartFilled.swiftUIImage,
                size: .m,
                type: .favorite
            ) {}
                .foregroundColor(WFColor.errorSoft)
                .padding([.top, .trailing], Grid.pt12)
        }
    }
    
    private var contentContainerView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            HStack(spacing: Grid.pt12) {
                titleContainerView
                ratingContainerView
            }
            
            Text("\(String(format: ".2f", route.distance))км • \(formatExtendedTravelTime()) • \(Int.random(in: 1 ... 12)) мест")
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
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: Grid.pt16, height: Grid.pt16)
                .foregroundStyle(.yellow)
            
            Text("333")
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
