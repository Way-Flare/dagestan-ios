//
//  SliderViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 16.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Combine
import SwiftUI

protocol ISliderViewModel: ObservableObject {
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>? { get set }
    var timerProgress: CGFloat { get set }
    var images: [URL] { get }
    var index: Int { get }
    
    func calculateProgress(for index: Int, width: CGFloat) -> CGFloat
    func updateTimerProgress(increment: CGFloat)
    func startTimer()
    func stopTimer()
    func animateTimerProgress()
}

final class SliderViewModel: ISliderViewModel {
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>? = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()

    @Published var timerProgress: CGFloat = 0
    let images: [URL]

    var index: Int {
        min(Int(timerProgress), images.count - 1) % images.count
    }

    init(images: [URL]) {
        self.images = images
    }

    func calculateProgress(for index: Int, width: CGFloat) -> CGFloat {
        let currentProgress = timerProgress - CGFloat(index)
        let clampedProgress = min(max(currentProgress, 0), 1)
        return width * clampedProgress
    }

    func updateTimerProgress(increment: CGFloat) {
        let currentImageIndex = Int(timerProgress) % images.count
        let newImageIndex = (currentImageIndex + Int(increment) + images.count) % images.count
        if currentImageIndex != newImageIndex {
            timerProgress = CGFloat(newImageIndex)
        }
    }

    func startTimer() {
        timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    }

    func stopTimer() {
        timer?.upstream.connect().cancel()
    }

    func animateTimerProgress() {
//        guard !isLoading else { return }

        if timerProgress < CGFloat(images.count) {
            withAnimation {
                timerProgress += 0.02
            }
        }

        if timerProgress >= CGFloat(images.count) {
            timerProgress = 0
        }
    }
}
