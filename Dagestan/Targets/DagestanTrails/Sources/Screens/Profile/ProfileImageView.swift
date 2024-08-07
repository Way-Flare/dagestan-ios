//
//  ProfileImageView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.

import SwiftUI

struct ProfileImageView: View {
    @Binding var offset: CGFloat
    @Binding private var loadedImage: Image?

    init(offset: Binding<CGFloat>, image: Binding<Image?>) {
        self._offset = offset
        self._loadedImage = image
    }

    var body: some View {
        GeometryReader { proxy in
            Group {
                if let loadedImage {
                    loadedImage
                        .resizable()
                        .aspectRatio(CGSize(width: 375, height: 280), contentMode: .fit)
                } else {
                    DagestanTrailsAsset.profileBg.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .padding(.horizontal, min(0, -offset))
            .frame(width: proxy.size.width, height: proxy.size.height + max(0, offset))
            .offset(y: min(0, -offset))
        }
        .aspectRatio(CGSize(width: 375, height: 280), contentMode: .fit)
    }
}
