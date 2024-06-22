//
//  FullScreenImageGallery.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

@MainActor
struct FullScreenImageGallery: View {
    let images: [URL]
    @State var selectedIndex: Int
    @State private var scale: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastDragValue: CGSize = .zero

    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 5.0

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            counterView
            galleryTabView
        }
        .navigationBarHidden(true)
        .background(Color.black, ignoresSafeAreaEdges: .all)
    }

    private var galleryTabView: some View {
        TabView(selection: $selectedIndex) {
            ForEach(images.indices, id: \.self) { index in
                GeometryReader { geometry in
                    LazyImage(url: images[index]) { state in
                        state.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(index)
                            .scaleEffect(scale)
                            .offset(offset)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        magnificationOnChanged(value.magnitude)
                                    }
                                    .onEnded { _ in
                                        magnificationOnEnded(in: geometry)
                                    }
                            )
                            .simultaneousGesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOnChanged(in: geometry, translation: value.translation)
                                    }
                                    .onEnded { value in
                                        dragOnEnded(translation: value.translation)
                                    }
                            )
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    private var counterView: some View {
        Text("\(selectedIndex + 1) / \(images.count)")
            .foregroundColor(WFColor.surfacePrimary)
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) { closeButton }
    }

    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(WFColor.iconPrimary)
                .padding(6)
                .background(WFColor.surfacePrimary)
                .cornerRadius(8)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }

    private func calculateBoundedOffset(_ dragAmount: CGSize, in geometry: GeometryProxy, scale: CGFloat) -> CGSize {
        let width = geometry.size.width
        let height = geometry.size.height
        let scaledWidth = width * scale
        let scaledHeight = height * scale

        let xBound = (scaledWidth - width) / 2
        let yBound = (scaledHeight - height) / 2

        let newX = min(max(dragAmount.width, -xBound), xBound)
        let newY = min(max(dragAmount.height, -yBound), yBound)

        return CGSize(width: newX, height: newY)
    }

    private func magnificationOnChanged(_ magnitude: CGFloat) {
        let tentativeScale = currentScale * magnitude
        let innerScale: CGFloat
        if tentativeScale >= minScale, tentativeScale <= maxScale {
            innerScale = tentativeScale
        } else if tentativeScale < minScale {
            innerScale = minScale - (minScale - tentativeScale) / 4
        } else {
            innerScale = maxScale + (tentativeScale - maxScale) / 10
        }

        withAnimation(.easeInOut(duration: 0.1)) {
            scale = innerScale
        }
    }

    private func magnificationOnEnded(in geometry: GeometryProxy) {
        withAnimation(.spring()) {
            if scale < minScale {
                scale = minScale
                offset = .zero
            } else if scale > maxScale {
                scale = maxScale
            }
            currentScale = scale
            offset = calculateBoundedOffset(offset, in: geometry, scale: scale)
        }
    }

    private func dragOnChanged(in geometry: GeometryProxy, translation: CGSize) {
        let dragAmount = CGSize(width: translation.width + lastDragValue.width,
                                height: translation.height + lastDragValue.height)
        if scale > 1.0 {
            withAnimation(.easeInOut(duration: 0.1)) {
                offset = calculateBoundedOffset(dragAmount, in: geometry, scale: scale)
            }
        } else {
            offset = .zero
            lastDragValue = .zero
        }
    }

    private func dragOnEnded(translation: CGSize) {
        if scale == 1.0 {
            let threshold: CGFloat = 50
            if translation.width > threshold, selectedIndex > 0 {
                selectedIndex -= 1
            } else if translation.width < -threshold, selectedIndex < images.count - 1 {
                selectedIndex += 1
            }
        } else {
            lastDragValue = offset
        }
    }
}

#Preview {
    FullScreenImageGallery(images: Place.mock.images, selectedIndex: 1)
}
