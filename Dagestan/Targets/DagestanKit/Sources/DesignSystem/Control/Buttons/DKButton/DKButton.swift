//
//  DKButton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

/// `DKButton` - пользовательская структура кнопки для интерфейса.
struct DKButton: View {
    let title: String
    let size: Size
    let state: DKButtonState
    let type: DKButtonStyle
    let leftImage: Image?
    let rightImage: Image?
    let action: (() -> Void)

    init(
        title: String,
        size: Size,
        state: DKButtonState,
        type: DKButtonStyle,
        leftImage: Image? = nil,
        rightImage: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.size = size
        self.state = state
        self.type = type
        self.action = action
        self.leftImage = leftImage
        self.rightImage = rightImage
    }

    var body: some View {
        Button(action: action ) {
            contentView
        }
        .buttonVisualStyle(
            style: type,
            appearance: stateStyle,
            cornerRadius: size.cornerRadius
        )
        .disabled(state == .disabled)
    }
}

extension DKButton {
    private var contentView: some View {
        HStack(spacing: Grid.pt8) {
            leftImage?
                .resizable()
                .frame(width: size.imageSize, height: size.imageSize)
            Text(title)
                .font(.manrope(weight: .semibold, size: size.fontSize))
            rightImage?
                .resizable()
                .frame(width: size.imageSize, height: size.imageSize)
        }
        .frame(height: size.height)
        .padding(.horizontal, size.horizontalPadding)
    }

    private var stateStyle: DKButtonAppearance {
        switch state {
            case .default: type.default
            case .hover: type.hover
            case .active: type.active
            case .disabled: type.disabled
        }
    }
}
