//
//  ContactView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 22.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem
import CoreLocation

struct ContactView: View {
    @Binding var isVisible: Bool
    let type: ContactType
    let action: (() -> Void)?
    
    init(
        isVisible: Binding<Bool>,
        type: ContactType,
        action: (() -> Void)? = nil
    ) {
        self._isVisible = isVisible
        self.type = type
        self.action = action
    }

    var body: some View {
        Button {
            if let action = action {
                action()
            } else {
                UIPasteboard.general.string = type.text
                withAnimation(.interactiveSpring) {
                    isVisible = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.interactiveSpring) {
                        isVisible = false
                    }
                }
            }
        } label: {
            HStack(spacing: Grid.pt12) {
                type.icon
                    .resizable()
                    .frame(width: Grid.pt20, height: Grid.pt20)
                    .foregroundStyle(WFColor.iconPrimary)
                Text(type.text ?? "Нет информации")
                    .foregroundStyle(type.text != nil ? WFColor.iconAccent : WFColor.foregroundSoft)
                    .font(.manropeRegular(size: Grid.pt16))
            }
            .frame(height: Grid.pt32)
        }
    }
}
