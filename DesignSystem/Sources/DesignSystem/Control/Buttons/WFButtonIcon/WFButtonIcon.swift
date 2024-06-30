//
//  WFButtonIcon.swift
//  CoreKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

public struct WFButtonIcon: View, Buildable {
    public let icon: Image
    public let size: Size
    public let state: WFButtonState
    public let type: WFButtonStyle
    public let action: (() -> Void)

    private var foregroundColor: Color?

    public init(
        icon: Image,
        size: Size,
        state: WFButtonState = .default,
        type: WFButtonStyle,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.state = state
        self.type = type
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
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

    public func foregroundColor(_ foregroundColor: Color) -> Self {
         map({ $0.foregroundColor = foregroundColor })
     }
}

extension WFButtonIcon {
    private var contentView: some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.imageSize, height: size.imageSize)
            .padding(size.padding)
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
