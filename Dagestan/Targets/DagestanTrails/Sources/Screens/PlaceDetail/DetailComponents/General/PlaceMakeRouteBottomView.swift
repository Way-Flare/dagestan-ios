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
    var onFavoriteAction: (() -> Void)?
    let shareUrl: URL?

    init(
        isFavorite: Bool,
        onFavoriteAction: (() -> Void)? = nil,
        shareUrl: URL?
    ) {
        self._isFavorite = State(wrappedValue: isFavorite)
        self.onFavoriteAction = onFavoriteAction
        self.shareUrl = shareUrl
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
                ) {}

                WFButtonIcon(
                    icon: isFavorite ? DagestanTrailsAsset.heartFilled.swiftUIImage : DagestanTrailsAsset.tabHeart.swiftUIImage,
                    size: .m,
                    type: .secondary
                ) {
                    onFavoriteAction?()
                    isFavorite.toggle()
                }
                .foregroundColor(isFavorite ? WFColor.errorPrimary : WFColor.accentActive)

                if let shareUrl {
                    ShareLink(item: shareUrl) {
                        WFButtonIcon(
                            icon: DagestanTrailsAsset.share.swiftUIImage,
                            size: .m,
                            type: .secondary
                        ) {}
                            .allowsHitTesting(false)
                    }
                    .buttonVisualStyle(
                        style: .secondary,
                        appearance: WFButtonSecondary().default,
                        cornerRadius: 12
                    )
                }
            }
            .frame(height: 68)
            .padding(.horizontal, 12)
            .background(WFColor.surfaceTertiary)
        }
    }
}
