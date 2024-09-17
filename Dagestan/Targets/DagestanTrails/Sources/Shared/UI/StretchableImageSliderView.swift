//
//  StretchableImageSliderView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 01.09.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct StretchableImageSliderView<Content: View>: View {
    let images: [URL]
    @Binding var showsBackdrop: Bool // Переменная для управления видимостью подложки
    let content: () -> Content

    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            StratchedContentView(safeArea: safeArea, size: size, images: images, content: content, showsBackdrop: $showsBackdrop)
                .ignoresSafeArea(.container, edges: .top)

        }
    }
}

private struct StratchedContentView<Content: View>: View {
    var safeArea: EdgeInsets
    var size: CGSize
    let images: [URL]
    let content: () -> Content
    @Binding var showsBackdrop: Bool // Переменная для управления видимостью подложки

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                imageSlider()

                VStack() {
                    content()
                }
                .padding(.top, Grid.pt13)
                .background(WFColor.surfaceSecondary)
                .cornerRadius(Grid.pt16, corners: [.topLeft, .topRight])
                .clipped()
                .offset(y: -Grid.pt20)
            }
        }
        .coordinateSpace(name: "SCROLL")
    }

    @ViewBuilder
    func imageSlider() -> some View {
        let height = size.height * 0.6 // Высота картинки

        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            ImageSliderView(images: images)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY: 0) )
                .clipped()
                .offset(y: -minY)
                .onChange(of: minY) { value in
                    showsBackdrop = value <= UIScreen.main.bounds.width * -1
                }

        }
        .frame(height: height + safeArea.top)
    }

}
