//
//  CompanyContactsSheetView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 03.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

/// view с контаками компании
struct CompanyContactsView: View {

    var body: some View {
        VStack(spacing: Grid.pt8) {
            Link(destination: URL(string: "https://t.me/way_flare")!) {
                ItemView(image: DagestanTrailsAsset.telegramLogo.swiftUIImage, title: "Telegram")
            }
            Link(destination: URL(string: "https://wa.me/message/R5ZOYUTGMW4BH1")!) {
                ItemView(image: DagestanTrailsAsset.whatsappLogo.swiftUIImage, title: "Whatsapp")
            }
        }
    }
}

private struct ItemView: View {
    let image: Image
    let title: String

    var body: some View {
        HStack(spacing: Grid.pt8) {
            ZStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(WFColor.surfaceTertiary)
                    .frame(width: Grid.pt52, height: Grid.pt52)
                    .cornerRadius(Grid.pt16, corners: .allCorners)
            }

            VStack(alignment: .leading, spacing: .zero) {
                Text(title)
                    .font(.manropeSemibold(size: Grid.pt16))
                    .foregroundStyle(WFColor.foregroundPrimary)
            }
            .frame(height: Grid.pt60)
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
    }
}
