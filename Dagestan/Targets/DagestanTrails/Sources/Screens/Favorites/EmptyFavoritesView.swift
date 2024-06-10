//
//  EmptyFavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

struct StateFavoritesView: View {
    let image: Image
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 8) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210, height: 210)
            Text(title)
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: 20))
            Text(message)
                .frame(width: 296)
                .multilineTextAlignment(.center)
                .foregroundStyle(DagestanKitAsset.fgSoft.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 16))
        }
    }
}
