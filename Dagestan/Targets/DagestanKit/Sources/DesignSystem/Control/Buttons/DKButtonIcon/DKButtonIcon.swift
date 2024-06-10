//
//  DKButtonIcon.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKButtonIcon: View, Buildable {
    public let icon: Image
    public let size: Size
    public let state: DKButtonState
    public let type: DKButtonStyle
    public let action: (() -> Void)
    
    private var foregroundColor: Color?

    public init(
        icon: Image,
        size: Size,
        state: DKButtonState = .default,
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
            cornerRadius: size.cornerRadius,
            foregroundColor: foregroundColor
        )
        .disabled(state == .disabled)
    }
    
    public func foregroundColor(_ foregroundColor: Color) -> Self {
         map({ $0.foregroundColor = foregroundColor })
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
