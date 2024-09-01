//
//  ImageSliderView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem
import NukeUI

struct ImageSliderView: View {
    @State private var selection = 0
    @State private var isOpenFullscreenImage = false
    private let images: [URL]
    private let canOpenFullscreen: Bool

    /// Инициализатор
    /// - Parameter images: Список урлов на картинки, которые надо отобразить в слайдере
    init(images: [URL], canOpenFullscreen: Bool = true) {
        self.images = images
        self.canOpenFullscreen = canOpenFullscreen
    }

    @ViewBuilder
    var body: some View {

        ZStack {
            WFColor.surfacePrimary
            TabView(selection : $selection){
                if images.isEmpty {
                    DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: Grid.pt200)
                        .allowsHitTesting(false)
                        .ignoresSafeArea()
                } else {
                    ForEach(0 ..< images.count, id: \.self) { index in
                        LazyImage(url: images[index]) { state in
                            if state.isLoading {
                                Rectangle()
                                    .fill()
                                    .skeleton()
                            } else if let image = state.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: UIScreen.main.bounds.width)
                                    .clipped()
                                    .skeleton(show: state.isLoading)
                            } else {
                                DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: Grid.pt200)
                                    .allowsHitTesting(false)
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
            }
            .onChange(of: selection) { newIndex in
                if newIndex < 0 {
                    selection = images.count - 1
                } else if newIndex >= images.count {
                    selection = 0
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
        }
        .ignoresSafeArea()
        .onTapGesture {
            guard canOpenFullscreen else { return }
            isOpenFullscreenImage.toggle()
        }
        .fullScreenCover(isPresented: $isOpenFullscreenImage) {
            FullScreenImageGallery(
                images: images,
                selectedIndex: selection
            )
        }
    }
}

//#Preview {
//    ImageSliderView(images: [
//        URL(string: "https://dagestan-trails.ru/media/app/place/Barhan_Sarykum_Apr_13.jpg")!,
//        URL(string: "https://dagestan-trails.ru/media/app/place/photo_2024-04-23_15-59-08.jpg")!,
//        URL(string: "https://dagestan-trails.ru/media/app/place/Barhan_Sarykum_May_6.jpg")!,
//        URL(string: "https://dagestan-trails.ru/media/app/place/Barhan_Sarykum_Sept_14.jpg")!
//    ])
//}
