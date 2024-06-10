//
//  BackButton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct BackButton: View {
    @Environment(\.dismiss) 
    var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .foregroundColor(DagestanKitAsset.bgSurface1.swiftUIColor)
                .frame(width: 32, height: 32)
                .overlay(
                    DagestanKitAsset.arrowArrowLeft2Linear.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(DagestanKitAsset.iconDefault.swiftUIColor)
                )
                .shadow(
                    color: DagestanKitAsset.accentDefault.swiftUIColor.opacity(0.2),
                    radius: 10
                )
        }
    }
}

#Preview {
    BackButton()
}
