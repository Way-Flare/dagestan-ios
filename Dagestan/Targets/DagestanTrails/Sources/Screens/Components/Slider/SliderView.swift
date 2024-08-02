//
//  SliderView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 16.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Combine
import DesignSystem
import NukeUI
import SwiftUI

@MainActor
struct SliderView: View {
    @State private var timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    @State private var timerProgress: CGFloat = 0
    private let images: [URL]

    init(images: [URL]) {
        self.images = images
    }

    var body: some View {
        imageView
            .onDisappear {
                stopTimer()
            }
    }

    @ViewBuilder private var imageView: some View {
        if !images.isEmpty {
            GeometryReader { geometry in
                LazyImage(url: images[index]) { state in
                    if state.isLoading {
                        Rectangle()
                            .fill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .skeleton()
                    } else if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .overlay(sliderView, alignment: .bottom)
                            .overlay(gestureOverlay)
                            .onReceive(timer) { _ in
                                animateTimerProgress()
                            }
                            .skeleton(show: state.isLoading)
                    } else {
                        DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .allowsHitTesting(false)
                    }
                }
                .onAppear {
                    print("Attempting to load image from URL: \(images[index].absoluteString)")
                }
            }
        } else {
            DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .allowsHitTesting(false)
        }
    }

    private var index: Int {
        min(Int(timerProgress), images.count - 1) % images.count
    }

    private func stopTimer() {
        timer.upstream.connect().cancel()
    }

    private func animateTimerProgress() {
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

// MARK: - Slider with progress logic

extension SliderView {
    @ViewBuilder private var sliderView: some View {
        if images.count > 1 {
            HStack(spacing: Grid.pt4) {
                ForEach(0 ..< images.count, id: \.self) { index in
                    progressCapsule(for: index)
                }
            }
            .frame(height: Grid.pt4)
            .padding(.horizontal, Grid.pt12)
            .padding(.bottom, Grid.pt8)
        }
    }

    private func progressCapsule(for index: Int) -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let progress = calculateProgress(for: index, width: width)

            Capsule()
                .fill(Color.white.opacity(0.5))
                .overlay(alignment: .leading) {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: progress)
                }
        }
    }

    private var gestureOverlay: some View {
        HStack(spacing: .zero) {
            gestureRectangle(by: -1)
            gestureRectangle(by: 1)
        }
    }

    private func gestureRectangle(by increment: CGFloat) -> some View {
        Rectangle()
            .fill(Color.black.opacity(0.01))
            .onTapGesture {
                updateTimerProgress(increment: increment)
            }
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
}

#Preview {
    SliderView(images: [])
}
