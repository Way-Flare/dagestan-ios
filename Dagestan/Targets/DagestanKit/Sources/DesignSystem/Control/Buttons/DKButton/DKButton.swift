//
//  DKButton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

/// `DKButton` - пользовательская структура кнопки для интерфейса.
public struct DKButton: View, Buildable {
    public let title: String
    public let size: Size
    public let state: DKButtonState
    public let type: DKButtonStyle
    public let subtitle: String?
    public let leftImage: Image?
    public let rightImage: Image?
    public let action: (() -> Void)
    
    private var foregroundColor: Color?

    public init(
        title: String,
        size: Size,
        state: DKButtonState,
        type: DKButtonStyle,
        subtitle: String? = nil,
        leftImage: Image? = nil,
        rightImage: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.size = size
        self.state = state
        self.type = type
        self.action = action
        self.subtitle = subtitle
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
            cornerRadius: size.cornerRadius,
            foregroundColor: foregroundColor
        )
        .disabled(state == .disabled)
    }
    
    public func foregroundColor(_ newForegroundColor: Color) {
        let _ = map { $0.foregroundColor = newForegroundColor }
    }
}

extension DKButton {
    private var contentView: some View {
        HStack(spacing: Grid.pt8) {
            leftImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.imageSize, height: size.imageSize)
            VStack(spacing: .zero) {
                Text(title)
                    .font(.manrope(weight: .semibold, size: size.titleFontSize))
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.manrope(weight: .semibold, size: size.subtitleFontSize))
                }
            }
            rightImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.imageSize, height: size.imageSize)
        }
        .frame(maxWidth: .infinity)
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
