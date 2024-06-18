//
//  SliderView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 16.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

@MainActor
struct SliderView: View {
    @StateObject private var viewModel: SliderViewModel

    init(images: [URL]) {
        self._viewModel = StateObject(wrappedValue: SliderViewModel(images: images))
    }

    var body: some View {
        imageView
            .onAppear {
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
    }

    @ViewBuilder private var imageView: some View {
        if !viewModel.images.isEmpty,
           let timer = viewModel.timer {
            GeometryReader { geometry in
                LazyImage(url: viewModel.images[viewModel.index]) { state in
                    state.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .overlay(sliderView, alignment: .bottom)
                        .overlay(gestureOverlay)
                        .onReceive(timer) { _ in
                            viewModel.animateTimerProgress()
                        }
                        .skeleton(show: state.isLoading)

                    if state.error != nil {
                        DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .onAppear {
                    print("Attempting to load image from URL: \(viewModel.images[viewModel.index].absoluteString)")
                }
            }
        } else {
            DagestanTrailsAsset.notAvaibleImage.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

// MARK: - Slider with progress logic

extension SliderView {
    @ViewBuilder private var sliderView: some View {
        if viewModel.images.count > 1 {
            HStack(spacing: Grid.pt4) {
                ForEach(0 ..< viewModel.images.count, id: \.self) { index in
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
            let progress = viewModel.calculateProgress(for: index, width: width)

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
                viewModel.updateTimerProgress(increment: increment)
            }
    }
}

#Preview {
    SliderView(images: Place.mock.images)
}
