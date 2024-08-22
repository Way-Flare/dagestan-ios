//
//  ChangeNameSheet.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 27.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct ChangeNameSheet: View {
    let placeholder: String
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: Grid.pt16) {
            title
            getUsernameTextField()
                .padding(.horizontal, Grid.pt16)
            getSaveButton()
                .padding(.horizontal, Grid.pt16)

            Spacer()
        }
    }
}

extension ChangeNameSheet {
    /// Заголовок с крестиком
    private var title: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Мой дорогой, как я могу к тебе обращаться?")
                .font(.manropeSemibold(size: Grid.pt16))
                .foregroundStyle(WFColor.foregroundPrimary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
        .padding(.top, Grid.pt20)
        .padding([.horizontal, .bottom], Grid.pt12)
    }

    func getUsernameTextField() -> some View {
        TextField("", text:  $viewModel.username)
            .font(.manropeRegular(size: Grid.pt16))
            .foregroundColor(WFColor.foregroundPrimary)
            .placeholder(
                when: viewModel.username.isEmpty,
                with: placeholder
            )
            .padding(Grid.pt12)
            .setBorder()
            .overlay(eraseButton)
            .background(WFColor.surfaceSecondary)
            .cornerRadius(Grid.pt8)

    }

    func getSaveButton() -> some View {
        WFButton(
            title: "Сохранить",
            size: .l,
            state: viewModel.profileState.isLoading ? .loading : .default,
            type: .primary
        ) {
            viewModel.patchProfile(with: .name(value: viewModel.username))
        }
    }

    private var eraseButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.username = !viewModel.username.isEmpty ? "" : viewModel.username
            } label: {
                if !viewModel.username.isEmpty {
                    Image(systemName: "multiply.circle.fill")
                        .frame(width: Grid.pt20, height: Grid.pt20)
                        .foregroundStyle(WFColor.iconSoft)
                        .frame(width: Grid.pt44, height: Grid.pt44)
                        .contentShape(Rectangle())
                }
            }
            .buttonStyle(.plain)
        }
    }
}
