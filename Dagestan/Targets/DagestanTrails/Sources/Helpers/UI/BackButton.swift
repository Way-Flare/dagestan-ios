//
//  BackButton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import SwiftUI
import DesignSystem

struct BackButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Rectangle()
                .cornerRadius(Grid.pt8, corners: .allCorners)
                .foregroundColor(WFColor.surfacePrimary)
                .frame(width: Grid.pt32, height: Grid.pt32)
                .overlay(
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Grid.pt16, height: Grid.pt16)
                        .foregroundStyle(WFColor.iconPrimary)
                )
                .shadow(
                    color: WFColor.accentPrimary.opacity(0.2),
                    radius: Grid.pt6
                )
        }
    }
}

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(WFColor.iconPrimary)
                .padding(6)
                .background(WFColor.surfacePrimary)
                .cornerRadius(8)
        }
    }
}

#Preview {
    BackButton()
}
