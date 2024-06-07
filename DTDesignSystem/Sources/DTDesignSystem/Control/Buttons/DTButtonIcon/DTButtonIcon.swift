//
//  DTButtonIcon.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

public struct DTButtonIcon: View {
    let icon: Image
    let size: Size
    let state: DTButtonState
    let type: DTButtonStyle
    let action: (() -> Void)
    
    public init(
        icon: Image,
        size: Size,
        state: DTButtonState,
        type: DTButtonStyle,
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

extension DTButtonIcon {
    private var contentView: some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.imageSize, height: size.imageSize)
            .padding(size.padding)
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
