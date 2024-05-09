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
    let service: IPlacesService
    let place: Place
    @State private var isShowingDetail = false

    var body: some View {
        VStack {
            Text(place.name)
                .padding()
                .background(.indigo)
            Button("View Details") {
                isShowingDetail = true
            }
        }
        .sheet(isPresented: $isShowingDetail) {
            PlaceDetailView(placeId: place.id, service: service)
        }
    }
}

struct ImagesView: View {
    @State var isLoading: Bool = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timerProgress: CGFloat = 0
    var onClose: () -> Void

    private let images: [String] = [
        "rocklee",
        "demon",
        "barr",
        "mountains",
        "rocklee",
        "demon",
        "barr",
        "mountains"
    ]

    private var index: Int {
        min(Int(timerProgress), images.count - 1)
    }

    var body: some View {
        ZStack(alignment: .top) {
            DagestanKitAsset.bgSurface1.swiftUIColor
                .frame(height: 294)
            VStack(spacing: Grid.pt8) {
                ZStack {
                    Image(images[index])
                        .resizable()
                        .frame(height: 174)
                        .aspectRatio(contentMode: .fit)
                        .cornerStyle(.constant(4, .bottomCorners))

                }
                .overlay(alignment: .bottom) {
                    sliderView
                }
                .skeleton(show: isLoading)
                .frame(maxWidth: .infinity)
                .overlay(
                    HStack(spacing: .zero) {
                        GestureRectangle(increment: -1, action: updateTimerProgress)
                        GestureRectangle(increment: 1, action: updateTimerProgress)
                    }
                )
                .skeleton(show: isLoading)
                .overlay(alignment: .topTrailing) {
                    buttonsView
                }
                .transition(.move(edge: .bottom))
                .onReceive(timer) { _ in
                    if timerProgress < CGFloat(images.count) {
                        withAnimation {
                            timerProgress += 0.02
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: Grid.pt6) {
                    HStack {
                        Text("Скалка")
                            .font(.manrope(weight: .semibold, size: 18))
                            .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                        Spacer()
                        HStack(spacing: Grid.pt4) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text("4.3")
                                .font(.manrope(weight: .regular, size: 14))
                                .foregroundStyle(DagestanKitAsset.fgSoft.swiftUIColor)
                        }
                    }
                    .skeleton(show: isLoading, cornerStyle: .constant(4))

                    Text("Открыто • до 21:00")
                        .font(.manrope(weight: .regular, size: 14))
                        .foregroundStyle(DagestanKitAsset.fgSoft.swiftUIColor)
                        .skeleton(show: isLoading, cornerStyle: .constant(4))

                    Text("Маршрут \"Дагестанский квест\": Погрузитесь в магию Дагестана, начав магию Дагестана, начав магию Дагестана, начав магию")
                        .font(.manrope(weight: .regular, size: 14))
                        .foregroundStyle(DagestanKitAsset.iconDefault.swiftUIColor)
                        .lineLimit(3)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .skeleton(show: isLoading, cornerStyle: .constant(4))

                }
                .padding(.horizontal, 8)
            }
        }
        .cornerStyle(.constant(16))
        .padding(.horizontal, 12)
        .shadow(radius: 5)

    }

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
    
    private var buttonsView: some View {
        HStack(spacing: Grid.pt8) {
            Spacer()
            DKButtonIcon(
                icon: DagestanTrailsAsset.computersAirpodsBold.swiftUIImage,
                size: .l,
                state: .default,
                type: .favorite
            ) {}
            DKButtonIcon(
                icon: DagestanTrailsAsset.essentialBatteryChargingBold.swiftUIImage,
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

    private func updateTimerProgress(increment: CGFloat) {
        let newProgress = timerProgress + increment
        timerProgress = min(max(newProgress, 0), CGFloat(images.count))
    }
}

#Preview {
    ImagesView {
        print("close")
    }
}

struct GestureRectangle: View {
    var increment: CGFloat
    var action: (CGFloat) -> Void

    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.01))
            .onTapGesture {
                action(increment)
            }
    }
}
