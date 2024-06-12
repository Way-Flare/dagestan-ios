//
//  PlaceView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import SwiftUI
import DesignSystem
import NukeUI

@MainActor
struct PlaceView: View {
    @Binding var isPlaceViewVisible: Bool
    @StateObject private var viewModel: PlaceViewModel

    init(place: Place, isVisible: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: PlaceViewModel(place: place))
        self._isPlaceViewVisible = isVisible
    }

    var body: some View {
        contentView
            .cornerStyle(.constant(16))
            .padding(.horizontal, 12)
            .shadow(radius: 5)
        //            .onReceive(timer) { _ in
        //                nextImage()
        //            }
    }

    //    private func nextImage() {
    //        if !isLoading {
    //            timerProgress = (timerProgress + 0.01).truncatingRemainder(dividingBy: CGFloat(place.images.count))
    //        }
    //    }

    private var contentView: some View {
        VStack(spacing: Grid.pt8) {
            imageView
            descriptionView.padding(.horizontal, Grid.pt8)
        }
        .padding(.bottom, Grid.pt12)
        .background(WFColor.surfacePrimary)
    }

    @ViewBuilder private var imageView: some View {
        ZStack(alignment: .topTrailing) {
            if viewModel.place.images.count != 0 {
                LazyImage(url: viewModel.place.images[viewModel.index]) { state in
                    state.image?
                        .resizable()
                        .frame(height: 174)
                        .aspectRatio(contentMode: .fit)
                        .cornerStyle(.constant(4, .bottomCorners))
                        .overlay(sliderView, alignment: .bottom)
                        .overlay(gestureOverlay)
                        .onReceive(viewModel.timer) { _ in
                            viewModel.animateTimerProgress()
                        }
                        .skeleton(show: state.isLoading)
                }
            }

            buttonsView
        }
    }
}

// MARK: - Slider with progress logic

extension PlaceView {
    @ViewBuilder private var sliderView: some View {
        if viewModel.place.images.count > 1 {
            HStack(spacing: Grid.pt4) {
                ForEach(0 ..< viewModel.place.images.count, id: \.self) { index in
                    progressCapsule(for: index)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
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

// MARK: - UI Elements

extension PlaceView {
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            titleAndRatingView
            operatingHoursView
            routeDescriptionView
        }
    }

    private var titleAndRatingView: some View {
        HStack {
            Text(viewModel.place.name)
                .font(.manropeSemibold(size: 18))
            Spacer()
            starRatingView
        }
        .skeleton(show: viewModel.isLoading, cornerStyle: .constant(4))
    }

    private var starRatingView: some View {
        HStack(spacing: Grid.pt4) {
            Image(systemName: "star")
                .resizable()
                .frame(width: 16, height: 16)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.yellow)

            Text(String(viewModel.place.rating ?? 0.0))
                .font(.manropeRegular(size: Grid.pt14))
                .foregroundStyle(WFColor.foregroundSoft)
        }
    }

    private var operatingHoursView: some View {
        Text(viewModel.place.workTime ?? "")
            .font(.manropeRegular(size: Grid.pt14))
            .skeleton(show: viewModel.isLoading, cornerStyle: .constant(4))
    }

    private var routeDescriptionView: some View {
        Text(viewModel.place.shortDescription ?? "")
            .font(.manropeRegular(size: Grid.pt14))
            .lineLimit(3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(show: viewModel.isLoading, cornerStyle: .constant(4))
    }

    private var buttonsView: some View {
        HStack(spacing: Grid.pt8) {
            Spacer()
            WFButtonIcon(
                icon: viewModel.currentFavoriteImage,
                size: .l,
                type: .favorite,
                action: viewModel.onFavorite
            )
            .foregroundColor(viewModel.currentFavoriteColor)
            WFButtonIcon(
                icon: DagestanTrailsAsset.close.swiftUIImage,
                size: .l,
                type: .favorite
            ) {
                isPlaceViewVisible = false
            }
        }
        .padding([.top, .trailing], 12)
    }
}
