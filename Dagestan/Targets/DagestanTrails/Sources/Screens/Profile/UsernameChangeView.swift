//
//  UsernameChangeView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

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
        .setCustomBackButton()
        .setCustomNavigationBarTitle(title: "Имя пользователя")
    }
}

extension UsernameChangeView {
    func getUsernameTextField() -> some View {
        TextField("", text: isUserChange ? $viewModel.username : $viewModel.email)
            .background(WFColor.surfacePrimary)
            .cornerRadius(8)
            .font(.manropeRegular(size: 16))
            .foregroundColor(WFColor.foregroundPrimary)
            .placeholder(
                when: isUserChange ? viewModel.username.isEmpty : viewModel.email.isEmpty,
                with: placeholder
            )
            .padding(12)
            .setBorder()
            .padding(.top, 12)
    }
    
    func getSaveButton() -> some View {
        WFButton(
            title: "Сохранить",
            size: .l,
            type: .primary
        ) {
            if let profile = viewModel.profileState.data {
                let newUsername = isUserChange ? viewModel.username : profile.username
                let newEmail = isUserChange ? profile.email : viewModel.email
                
                let request = ProfileRequestDTO(
                    avatar: profile.avatar?.absoluteString ?? "",
                    username: newUsername ?? "username",
                    email: newEmail ?? ""
                )
                
                viewModel.patchProfile(with: request)
            }
        }
    }

}
