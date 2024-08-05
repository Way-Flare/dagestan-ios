//
//  PlaceMakeRouteBottomView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct PlaceMakeRouteBottomView: View {
    @State var isFavorite: Bool
    @State var showAlert: Bool = false
    var onFavoriteAction: (() -> Void)?

    init(
        isFavorite: Bool,
        onFavoriteAction: ( () -> Void)? = nil
    ) {
        self._isFavorite = State(wrappedValue: isFavorite)
        self.onFavoriteAction = onFavoriteAction
    }

    var body: some View {
        VStack(spacing: .zero) {
            Divider()
                .background(WFColor.borderMuted)
            HStack(spacing: 12) {
                WFButton(
                    title: "Построить маршрут",
                    size: .m,
                    type: .primary
                ) {
                    showAlert = true
                }
                .noFeatureAlert(isPresented: $showAlert)

                WFButtonIcon(
                    icon: isFavorite ? DagestanTrailsAsset.heartFilled.swiftUIImage : DagestanTrailsAsset.tabHeart.swiftUIImage,
                    size: .m,
                    type: .secondary
                ) {
                    onFavoriteAction?()
                    isFavorite.toggle()
                }
                .foregroundColor(isFavorite ? WFColor.errorPrimary : WFColor.accentActive)

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
