//
//  SlideButtonView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct SlideButtonView: View {
    @State private var showUnlock = false
    
    private var actionSuccess: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            SwipeToUnlockView()
                .onSwipeSuccess {
                    actionSuccess?()
                    showUnlock = false
                }
        }
        .onAppear {
            showUnlock = true
        }
    }
    
    func onSwipeSuccessAction(completion: @escaping () -> Void) -> some View {
        var copied = self
        copied.actionSuccess = completion
        return copied
    }
}

#Preview {
    SlideButtonView()
}

struct SwipeToUnlockView: View {
    @State private var thumbSize: CGSize = Design.inactiveThumbSize
    @State private var dragOffset: CGSize = .zero
    @State private var isEnough = false
    private var actionSuccess: (() -> Void)?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: Design.trackSize.width, height: Design.trackSize.height)
                .foregroundColor(WFColor.accentActive).opacity(0.5)
            Text("Свайпни, чтобы получить промокод")
                .font(.manropeSemibold(size: 12))
                .offset(x: 20)
                .foregroundColor(WFColor.iconInverted)
                .opacity(Double(1 - dragOffset.width * 2 / Design.trackSize.width))
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: thumbSize.width, height: thumbSize.height)
                    .foregroundStyle(WFColor.accentActive)
                DagestanTrailsAsset.ticketDiscountLinear.swiftUIImage
                    .foregroundColor(WFColor.iconInverted)
            }
            .offset(x: getDragOffsetX(), y: 0)
            .animation(.spring(response: 0.3, dampingFraction: 0.8))
            .gesture(
                DragGesture()
                    .onChanged { value in handleDragChanged(value: value) }
                    .onEnded { _ in handleDragEnded() }
            )
        }
    }
    
    private func getDragOffsetX() -> CGFloat {
        let clampedDragOffsetX = dragOffset.width.clamp(lower: 0, upper: Design.trackSize.width - thumbSize.width)
        return -(Design.trackSize.width / 2 - thumbSize.width / 2 - clampedDragOffsetX)
    }
    
    // MARK: - Haptic
    
    private func indicateCanLiftFinger() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func indicateSwipeWasSuccessfull() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // MARK: - Gesture
    
    private func handleDragChanged(value: DragGesture.Value) {
        dragOffset = value.translation
        
        let dragWidth = value.translation.width
        let targetDragWidth = Design.trackSize.width - thumbSize.width * 2
        let wasInitiated = dragWidth > 2
        let didReachTarget = dragWidth > targetDragWidth
        
        thumbSize = wasInitiated ? Design.activeThumbSize : Design.inactiveThumbSize
        
        isEnough = didReachTarget
        if didReachTarget {
            if !isEnough {
                indicateCanLiftFinger()
            }
        }
    }
    
    private func handleDragEnded() {
        dragOffset = .zero
        
        if isEnough {
            dragOffset = CGSize(width: Design.trackSize.width - thumbSize.width, height: 0)
            if let actionSuccess {
                indicateSwipeWasSuccessfull()
                actionSuccess()
                dragOffset = .zero
                thumbSize = Design.inactiveThumbSize
            }
        } else {
            dragOffset = .zero
            thumbSize = Design.inactiveThumbSize
        }
    }
}

extension SwipeToUnlockView {
    func onSwipeSuccess(_ action: @escaping () -> Void) -> some View {
        var copied = self
        copied.actionSuccess = action
        return copied
    }
}

extension SwipeToUnlockView {
    enum Design {
        static let inactiveThumbSize = CGSize(width: 50, height: 50)
        static let activeThumbSize = CGSize(width: 55, height: 50)
        static let trackSize = CGSize(width: 280, height: 50)
    }
}
