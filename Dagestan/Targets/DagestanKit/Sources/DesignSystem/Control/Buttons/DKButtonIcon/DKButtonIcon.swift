//
//  DKButtonIcon.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct DKButtonIcon: View {
    let icon: Image
    let size: Size
    let state: DKButtonState
    let type: DKButtonStyle
    let action: (() -> Void)

    init(
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

    var body: some View {
        Button(action: action) {
            contentButton
        }
        .disabled(state == .disabled)
    }
}

extension DKButtonIcon {
    private var contentButton: some View {
        icon
            .resizable()
            .frame(width: size.imageSize, height: size.imageSize)
            .foregroundStyle(stateStyle.foregroundColor)
            .padding(size.padding)
            .background(stateStyle.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
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

#Preview {
    DKButtonIcon(
        icon: Image(systemName: "target"),
        size: .l,
        state: .disabled,
        type: .primary
    ) {
        print("fsa")
    }
}
