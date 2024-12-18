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

struct IdentifiableInt: Identifiable {
    let id: Int
}

struct ImageCarousel: View {
    let images: [URL]
    @State private var selectedImageIndex: IdentifiableInt?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    LazyImage(url: images[index]) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 96, height: 96)
                                .cornerStyle(.constant(4))
                        } else {
                            Rectangle()
                                .fill()
                                .frame(width: 96, height: 96)
                                .skeleton()
                                .cornerStyle(.constant(4))
                        }
                    }
                    .onTapGesture {
                        selectedImageIndex = IdentifiableInt(id: index)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .fullScreenCover(item: $selectedImageIndex) { index in
            FullScreenImageGallery(images: images, selectedIndex: index.id)
        }
    }
}
