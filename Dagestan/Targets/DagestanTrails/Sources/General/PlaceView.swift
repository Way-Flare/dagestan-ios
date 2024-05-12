//
//  PlaceView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

struct PlaceView: View {
    @State private var place: Place
    @State private var isLoading = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timerProgress: CGFloat = 0

    private let onClose: () -> Void
    private let images = [
        "rocklee", "demon", "barr", "mountains",
        "rocklee", "demon", "barr", "mountains"
    ]

    private var index: Int {
        min(Int(timerProgress), images.count - 1) % images.count
    }

    init(place: Place, onClose: @escaping () -> Void) {
        self.place = place
        self.onClose = onClose
    }

    var body: some View {
        contentView
            .cornerStyle(.constant(16))
            .padding(.horizontal, 12)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom))
            .animation(.default, value: place)
    }

    private var contentView: some View {
        VStack(spacing: Grid.pt8) {
            imageView
                .overlay(sliderView, alignment: .bottom)
                .skeleton(show: isLoading)
            descriptionView.padding(.horizontal, Grid.pt8)
        }
        .padding(.bottom, Grid.pt12)
        .background(DagestanKitAsset.bgSurface1.swiftUIColor)
    }

    private var imageView: some View {
        Image(images[index])
            .resizable()
            .frame(height: 174)
            .aspectRatio(contentMode: .fit)
            .cornerStyle(.constant(4, .bottomCorners))
            .overlay(gestureOverlay)
            .overlay(buttonsView, alignment: .topTrailing)
            .transition(.move(edge: .bottom))
            .onReceive(timer) { _ in
                animateTimerProgress()
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
    
    private func updateTimerProgress(increment: CGFloat) {
        let newProgress = timerProgress + increment
        timerProgress = min(max(newProgress, 0), CGFloat(images.count))
    }

    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            titleAndRatingView
            operatingHoursView
            routeDescriptionView
        }
    }

    private var titleAndRatingView: some View {
        HStack {
            Text(place.name)
                .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: 18))
            Spacer()
            starRatingView
        }
        .skeleton(show: isLoading, cornerStyle: .constant(4))
    }

    private var starRatingView: some View {
        HStack(spacing: Grid.pt4) {
            DagestanTrailsAsset.supportStarBold.swiftUIImage
                .resizable()
                .frame(width: 16, height: 16)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.yellow)

            Text(String(place.rating ?? 0.0))
                .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 14))
                .foregroundStyle(DagestanKitAsset.fgSoft.swiftUIColor)
        }
    }

    private var operatingHoursView: some View {
        Text(place.workTime ?? "")
            .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 14))
            .skeleton(show: isLoading, cornerStyle: .constant(4))
    }

    private var routeDescriptionView: some View {
        Text(place.shortDescription ?? "")
            .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 14))
            .lineLimit(3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .skeleton(show: isLoading, cornerStyle: .constant(4))
    }

    private var buttonsView: some View {
        HStack(spacing: Grid.pt8) {
            Spacer()
            DKButtonIcon(
                icon: DagestanTrailsAsset.supportHeartLinear.swiftUIImage,
                size: .l,
                state: .default,
                type: .favorite
            ) {}
            DKButtonIcon(
                icon: DagestanTrailsAsset.essentialCloseLinier.swiftUIImage,
                size: .l,
                state: .default,
                type: .favorite,
                action: onClose
            )
        }
        .padding([.top, .trailing], 12)
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

    private func calculateProgress(for index: Int, width: CGFloat) -> CGFloat {
        let currentProgress = timerProgress - CGFloat(index)
        let clampedProgress = min(max(currentProgress, 0), 1)
        return width * clampedProgress
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

extension PlaceView {
    @ViewBuilder private var sliderView: some View {
        if images.count > 1 {
            HStack(spacing: 4) {
                ForEach(0 ..< images.count, id: \.self) { index in
                    progressCapsule(for: index)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    let place = Place(
        id: 1_245_125,
        coordinate: .init(latitude: 6.24241, longitude: 6.1235125125),
        name: "Скалка",
        shortDescription: "Маршрут \"Дагестанский квест\": Погрузитесь в магию Дагестана, начав магию Дагестана, начав магию Дагестана, начав магию",
        images: [URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fclipground.com%2Fimg-src-data-image-png.html&psig=AOvVaw1qEEFBVlDpwdvOr6bQT098&ust=1715521395988000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCOi6pK3dhYYDFQAAAAAdAAAAABAE")!],
        rating: 5.0,
        workTime: "Открыто • до 21:00",
        tags: nil,
        feedbackCount: nil
    )
    return PlaceView(place: place) {
        print("close")
    }
}

// struct PlaceView: View {
//    let service: IPlacesService
//    let place: Place
//    @State private var isShowingDetail = false
//
//    var body: some View {
//        VStack {
//            Text(place.name)
//                .padding()
//                .background(.indigo)
//            Button("View Details") {
//                isShowingDetail = true
//            }
//        }
//        .sheet(isPresented: $isShowingDetail) {
//            PlaceDetailView(placeId: place.id, service: service)
//        }
//    }
// }
