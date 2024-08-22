//
//  WFChips.swift
//
//  Created by Рассказов Глеб on 09.06.2024.
//

import SwiftUI

public struct WFChips: View {
    @State var isActive = false
    private let icon: Image
    private let name: String
    private let action: (() -> Void)?

    private var closeIcon: Image {
        Image(systemName: "xmark")
    }

    private var foregroundColor: Color {
        isActive
            ? WFColor.accentInverted
            : WFColor.foregroundPrimary
    }

    private var backgroundColor: Color {
        isActive
            ? WFColor.accentSoft
            : WFColor.surfacePrimary
    }

    public init(
        icon: Image,
        name: String,
        isActive: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.name = name
        self.isActive = isActive
        self.action = action
    }

    public var body: some View {
        Button {
            withAnimation(.easeOut) {
                isActive.toggle()
            }
            action?()
        } label: {
            HStack(spacing: Grid.pt8) {
                HStack(spacing: Grid.pt4) {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Grid.pt18, height: Grid.pt18)
                    Text(name)
                }

                if isActive {
                    closeIcon
                        .resizable()
                        .frame(width: Grid.pt10, height: Grid.pt10)
                        .foregroundStyle(foregroundColor)
                        .bold()
                }
            }
        }
        .foregroundStyle(foregroundColor)
        .font(.manropeRegular(size: Grid.pt16))
        .frame(height: Grid.pt32)
        .padding(.horizontal, Grid.pt8)
        .background(backgroundColor)
        .cornerStyle(.constant(Grid.pt6))
        .padding(.vertical)
    }
}

#Preview {
    HStack{
        WFChips(icon: Image(systemName: "tree"), name: "Природа")
        WFChips(icon: Image(systemName: "cup.and.saucer"), name: "Еда")
        WFChips(icon: Image(systemName: "building.columns"), name: "Достопримечательности")
    }
}
