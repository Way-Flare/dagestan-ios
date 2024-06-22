//
//  ImageCarousel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 17.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

struct ImageCarousel: View {
    let images: [URL]
    @State private var selectedImageIndex: Int?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    NavigationLink(destination: FullScreenImageGallery(images: images, selectedIndex: index)) {
                        LazyImage(url: images[index]) { state in
                            state.image?
                                .resizable()
                                .frame(width: 96, height: 96)
                                .aspectRatio(contentMode: .fit)
                                .cornerStyle(.constant(4))
                        }
                    }
                }
            }
        }
    }
}
