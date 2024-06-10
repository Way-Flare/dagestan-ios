//
//  PlaceViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Combine
import SwiftUI
import DagestanKit

final class PlaceViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    @Published var place: Place
    @Published var timerProgress: CGFloat = 0
    @Published var isSelectedFavorite = false
    
    var index: Int {
        min(Int(timerProgress), place.images.count - 1) % place.images.count
    }
    
    var currentFavoriteImage: Image {
        isSelectedFavorite ? DagestanKitAsset.supportHeartBold.swiftUIImage
                           : DagestanKitAsset.supportHeartLinear.swiftUIImage
    }
    var currentFavoriteColor: Color {
        isSelectedFavorite ? DagestanKitAsset.errorSoft.swiftUIColor
                           : DagestanKitAsset.onAccent.swiftUIColor
    }

    init(place: Place) {
        self.place = place
    }
    
    func calculateProgress(for index: Int, width: CGFloat) -> CGFloat {
        let currentProgress = timerProgress - CGFloat(index)
        let clampedProgress = min(max(currentProgress, 0), 1)
        return width * clampedProgress
    }
    
    func updateTimerProgress(increment: CGFloat) {
        let currentImageIndex = Int(timerProgress) % place.images.count
        let newImageIndex = (currentImageIndex + Int(increment) + place.images.count) % place.images.count
        if currentImageIndex != newImageIndex {
            timerProgress = CGFloat(newImageIndex)
        }
    }
    
    func animateTimerProgress() {
        guard !isLoading else { return }

        if timerProgress < CGFloat(place.images.count) {
            withAnimation {
                timerProgress += 0.02
            }
        }

        if timerProgress >= CGFloat(place.images.count) {
            timerProgress = 0
        }
    }
    
    func onClose() {
        print("close action")
    }
    
    func onFavorite() {
        isSelectedFavorite.toggle()
        print("favorite action")
    }
}
