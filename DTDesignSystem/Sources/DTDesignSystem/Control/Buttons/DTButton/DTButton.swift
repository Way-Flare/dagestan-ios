//
//  DTButton.swift
//
//  Created by Рассказов Глеб on 20.04.2024.


import SwiftUI

/// `DTButton` - пользовательская структура кнопки для интерфейса.
public struct DTButton: View {
    let title: String
    let size: Size
    let state: DTButtonState
    let type: DTButtonStyle
    let leftImage: Image?
    let rightImage: Image?
    let action: (() -> Void)

    public init(
        title: String,
        size: Size,
        state: DTButtonState,
        type: DTButtonStyle,
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

    public var body: some View {
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

extension DTButton {
    private var contentView: some View {
        HStack(spacing: Grid.pt8) {
            leftImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.imageSize, height: size.imageSize)
            Text(title)
                .font(.custom("Manrope-SemiBold", size: size.fontSize))
            rightImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.imageSize, height: size.imageSize)
        }
        .frame(height: size.height)
        .padding(.horizontal, size.horizontalPadding)
    }

    private var stateStyle: DTButtonAppearance {
        switch state {
            case .default: type.default
            case .hover: type.hover
            case .active: type.active
            case .disabled: type.disabled
        }
    }
}
