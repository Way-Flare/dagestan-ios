//
//  PlaceMakeRouteBottomView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import CoreLocation

struct PlaceMakeRouteBottomView: View {
    @AppStorage("isAuthorized") var isAuthorized = false
    @State var isFavorite: Bool
    @State var showAlert = false
    @State var showNotAuthorizedAlert = false
    private let coordinates: [CLLocationCoordinate2D]


    var onFavoriteAction: (() -> Void)?
    let shareUrl: URL?

    init(
        coordinates: [CLLocationCoordinate2D],
        isFavorite: Bool,
        onFavoriteAction: (() -> Void)? = nil,
        shareUrl: URL?
    ) {
        self.coordinates = coordinates
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
                    let coordForUrl = coordinates.reduce("") { partialResult, coordinate in
                        return partialResult + "&daddr=" + "\(coordinate.latitude),\(coordinate.longitude)"
                    }
                    guard let url = URL(string: "http://maps.apple.com/maps?\(coordForUrl)") else { return }
                    UIApplication.shared.open(url)
                }

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
                .notAuthorizedAlert(isPresented: $showNotAuthorizedAlert)

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
