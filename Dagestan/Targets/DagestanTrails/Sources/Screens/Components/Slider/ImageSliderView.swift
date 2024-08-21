//
//  ImageSliderView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import NukeUI

struct ImageSliderView: View {
    @State private var selection = 0

    private let images: [URL]

    /// Инициализатор
    /// - Parameter images: Список урлов на картинки, которые надо отобразить в слайдере
    init(images: [URL]) {
        self.images = images
    }

    var body: some View {

        ZStack{

            Color.black

            if #available(iOS 17.0, *) {
                TabView(selection : $selection){
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
                                    .skeleton(show: state.isLoading)
                            } else {
                                DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .allowsHitTesting(false)
                            }
                        }
                        .ignoresSafeArea()
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
            } else {
                // Fallback on earlier versions
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ImageSliderView(images: [
        URL(string: "https://dagestan-trails.ru/media/app/place/Barhan_Sarykum_Apr_13.jpg")!,
        URL(string: "https://dagestan-trails.ru/media/app/place/photo_2024-04-23_15-59-08.jpg")!,
        URL(string: "https://dagestan-trails.ru/media/app/place/Barhan_Sarykum_May_6.jpg")!,
        URL(string: "https://dagestan-trails.ru/media/app/place/Barhan_Sarykum_Sept_14.jpg")!
    ])
}
