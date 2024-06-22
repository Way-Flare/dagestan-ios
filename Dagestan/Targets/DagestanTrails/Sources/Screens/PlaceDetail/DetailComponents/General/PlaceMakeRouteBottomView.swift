//
//  PlaceMakeRouteBottomView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct PlaceMakeRouteBottomView: View {
    var body: some View {
        VStack(spacing: .zero) {
            Divider()
                .background(WFColor.borderMuted)
            HStack(spacing: 12) {
                WFButton(
                    title: "Построить маршрут",
                    size: .m,
                    type: .primary
                ) {}

                WFButtonIcon(
                    icon: DagestanTrailsAsset.heartFilled.swiftUIImage,
                    size: .m,
                    type: .secondary
                ) {}
                    .foregroundColor(WFColor.errorPrimary)

                WFButtonIcon(
                    icon: DagestanTrailsAsset.share.swiftUIImage,
                    size: .m,
                    type: .secondary
                ) {}
            }
            .frame(height: 68)
            .padding(.horizontal, 12)
            .background(WFColor.surfaceTertiary)
        }
    }
}

#Preview {
    PlaceMakeRouteBottomView()
}
