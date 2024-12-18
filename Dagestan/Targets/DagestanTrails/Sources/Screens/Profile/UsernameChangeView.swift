//
//  UsernameChangeView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct UsernameChangeView: View {
    let isUserChange: Bool
    let placeholder: String
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: Grid.pt16) {
            getUsernameTextField()
            getSaveButton()

            Spacer()
        }
        .padding(.horizontal, Grid.pt16)
        .background(WFColor.surfacePrimary)
        .setCustomBackButton()
        .setCustomNavigationBarTitle(title: "Имя пользователя")
    }
}

extension UsernameChangeView {
    func getUsernameTextField() -> some View {
        TextField("", text: isUserChange ? $viewModel.username : $viewModel.email)
            .font(.manropeRegular(size: Grid.pt16))
            .foregroundColor(WFColor.foregroundPrimary)
            .placeholder(
                when: isUserChange ? viewModel.username.isEmpty : viewModel.email.isEmpty,
                with: placeholder
            )
            .padding(Grid.pt12)
            .setBorder()
            .overlay(eraseButton)
            .background(WFColor.surfacePrimary)
            .cornerRadius(Grid.pt8)
            .padding(.top, Grid.pt12)

    }

    func getSaveButton() -> some View {
        WFButton(
            title: "Сохранить",
            size: .l,
            state: viewModel.profileState.isLoading ? .loading : .default,
            type: .primary
        ) {
            viewModel.patchProfile(
                with: isUserChange
                    ? .name(value: viewModel.username)
                    : .email(value: viewModel.email)
            )
        }
    }

    private var eraseButton: some View {
        HStack {
            Spacer()
            Button {
                if isUserChange {
                    viewModel.username = !viewModel.username.isEmpty ? "" : viewModel.username
                } else {
                    viewModel.email = !viewModel.email.isEmpty ? "" : viewModel.email
                }
            } label: {
                if !(isUserChange ? viewModel.username.isEmpty : viewModel.email.isEmpty) {
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
