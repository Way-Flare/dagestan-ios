//
//  RoutePlaceInfoView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct PlaceRouteInfoView: View {
    let title: String
    let items: [RoutePlaceModel]?
    
    var body: some View {
        if let items {
            VStack(alignment: .leading, spacing: Grid.pt12) {
                HStack(spacing: Grid.pt8) {
                    Text(title)
                        .font(.manropeSemibold(size: Grid.pt18))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    
                    DagestanTrailsAsset.routingBulk.swiftUIImage
                        .resizable()
                        .frame(width: Grid.pt16, height: Grid.pt16)
                        .padding(.vertical, Grid.pt4)
                        .padding(.horizontal, Grid.pt6)
                        .background(WFColor.surfaceSecondary)
                }
                RoutePlacesView(items: items, isRoutes: false)
            }
        }
    }
}

#Preview {
    PlaceRouteInfoView(
        title: "Это место в маршрутах",
        items: PlaceDetail.mock().routes.map { $0.asDomain() }
    )
}
