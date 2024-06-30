//
//  WFButton.swift
//
//  Created by Рассказов Глеб on 20.04.2024.
//

import SwiftUI

/// `WFButton` - пользовательская структура кнопки для интерфейса.
public struct WFButton: View, Buildable {
    public let title: String
    public let size: Size
    public let state: WFButtonState
    public let type: WFButtonStyle
    public let subtitle: String?
    public let leftImage: Image?
    public let rightImage: Image?
    public let action: (() -> Void)

    private var foregroundColor: Color?

    public init(
        title: String,
        size: Size,
        state: WFButtonState = .default,
        type: WFButtonStyle,
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
        .disabled(state == .disabled || state == .loading)
    }

    public func foregroundColor(_ newForegroundColor: Color) {
        let _ = map { $0.foregroundColor = newForegroundColor }
    }
}

extension WFButton {
    private var contentView: some View {
        HStack(spacing: Grid.pt8) {
            if state == .loading {
                WFSpinner()
            } else {
                leftImage?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.imageSize, height: size.imageSize)
                VStack(spacing: .zero) {
                    Text(title)
                        .font(.manropeSemibold(size: size.titleFontSize))
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.manropeSemibold(size: size.subtitleFontSize))
                    }
                }
                rightImage?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.imageSize, height: size.imageSize)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: size.height)
        .padding(.horizontal, size.horizontalPadding)
    }

    private var stateStyle: WFButtonAppearance {
        switch state {
            case .default: type.default
            case .hover: type.hover
            case .active: type.active
            case .disabled: type.disabled
            case .loading: type.default
        }
    }
}
