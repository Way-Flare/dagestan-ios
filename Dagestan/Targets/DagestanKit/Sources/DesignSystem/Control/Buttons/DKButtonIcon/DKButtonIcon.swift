//
//  DKButtonIcon.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKButtonIcon: View {
    public let icon: Image
    public let size: Size
    public let state: DKButtonState
    public let type: DKButtonStyle
    public let action: (() -> Void)

    public init(
        icon: Image,
        size: Size,
        state: DKButtonState,
        type: DKButtonStyle,
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
            cornerRadius: size.cornerRadius
        )
        .disabled(state == .disabled)
    }
}

extension DKButtonIcon {
    private var contentView: some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.imageSize, height: size.imageSize)
            .padding(size.padding)
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
