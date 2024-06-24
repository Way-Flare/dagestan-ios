//
//  ItemRowView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ItemRowView: View {
    let image: Image
    let title: String
    let subtitle: String?
    let isRoutes: Bool
    
    var body: some View {
        HStack(spacing: Grid.pt8) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Grid.pt28, height: Grid.pt28)
                .cornerStyle(.round)
                .isHidden(!isRoutes)
            VStack(alignment: .leading, spacing: .zero) {
                Text(title)
                    .font(.manropeSemibold(size: Grid.pt16))
                    .foregroundStyle(WFColor.foregroundPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(.manropeRegular(size: Grid.pt13))
                        .foregroundStyle(WFColor.foregroundSoft)
                }
            }
            .padding(.leading, isRoutes ? Grid.pt12 : .zero)
            .frame(height: Grid.pt48)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)

            DagestanTrailsAsset.chevronRight.swiftUIImage
                .resizable()
                .frame(width: Grid.pt16, height: Grid.pt24)
                .foregroundStyle(WFColor.iconPrimary)
        }
        .padding(.horizontal, Grid.pt12)
        .padding(.vertical, Grid.pt4)
        .background(WFColor.surfacePrimary)
        .cornerRadius(12)
    }
}

#Preview {
    RoutePlacesView(items: PlaceDetail.mock().routes.map { $0.asDomain() }, isRoutes: false)
}
