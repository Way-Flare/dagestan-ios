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
    @AppStorage("isAuthorized") var isAuthorized = false
    @State var isFavorite: Bool
    @State var showAlert = false
    @State var showNotAuthorizedAlert = false
    
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
            HStack(spacing: Grid.pt12) {
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
                    guard isAuthorized else {
                        showNotAuthorizedAlert = true
                        return
                    }
                    onFavoriteAction?()
                    isFavorite.toggle()
                }
                .foregroundColor(isFavorite ? WFColor.errorPrimary : WFColor.accentActive)
                .notAutorizedAlert(isPresented: $showNotAuthorizedAlert)

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
                        cornerRadius: Grid.pt12
                    )
                }
            }
            .frame(height: Grid.pt68)
            .padding(.horizontal, Grid.pt12)
            .background(WFColor.surfaceTertiary)
        }
    }
}
