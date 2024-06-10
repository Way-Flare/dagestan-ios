//
//  DKChips.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 09.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKChips: View {
    @State var isActive = false
    private let icon: Image
    private let name: String
    private let action: (() -> Void)?
    
    private var closeIcon: Image {
        DagestanKitAsset.essentialCloseOutline.swiftUIImage
    }
    
    private var foregroundColor: Color {
        isActive
            ? DagestanKitAsset.onAccent.swiftUIColor
            : DagestanKitAsset.fgDefault.swiftUIColor
    }
    
    private var backgroundColor: Color {
        isActive
            ? DagestanKitAsset.accentActive.swiftUIColor
            : DagestanKitAsset.bgSurface1.swiftUIColor
    }
    
    public init(
        icon: Image,
        name: String,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.name = name
        self.action = action
    }
    
    public var body: some View {
        Button {
            withAnimation(.easeOut) {
                isActive.toggle()
            }
            action?()
        } label: {
            HStack(spacing: 8) {
                HStack(spacing: 4) {
                    icon
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(name)
                }
                
                if isActive {
                    closeIcon
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(foregroundColor)
                }
            }
        }
        .foregroundStyle(foregroundColor)
        .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 16))
        .frame(height: 32)
        .padding(.horizontal, 8)
        .background(backgroundColor)
        .cornerStyle(.constant(6))
        .padding(.vertical)
    }
}

#Preview {
    DKChips(icon: DagestanKitAsset.essentialTreeLinear.swiftUIImage, name: "Природа")
}
