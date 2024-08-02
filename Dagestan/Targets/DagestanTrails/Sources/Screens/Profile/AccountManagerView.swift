//
//  AccountManagerView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 28.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct AccountManagerView: View {
    @State private var showAlert = false
    @EnvironmentObject var viewModel: ProfileViewModel
    let avatar: URL?

    var body: some View {
        VStack(spacing: Grid.pt10) {
            ForEach(MenuItemType.allCases, id: \.self) { item in
                NavigationLink(destination: getDestination(for: item)) {
                    getMenuView(for: item)
                }
                .buttonStyle(DSPressedButtonStyle())
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Grid.pt12)
        .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
        .setCustomBackButton()
        .setCustomNavigationBarTitle(title: "Управление аккаунтом")
    }
}

// MARK: - Menu

extension AccountManagerView {
    @ViewBuilder
    func getDestination(for item: MenuItemType) -> some View {
        switch item {
            case .username: UsernameChangeView(isUserChange: true, placeholder: "Введите имя", viewModel: viewModel)
            case .userPhoto: UserChangePhotoView(viewModel: viewModel, avatar: avatar)
            case .changeEmail: UsernameChangeView(isUserChange: false, placeholder: "Введите почту", viewModel: viewModel)
            case .deleteAccount: EmptyView()
        }
    }

    @ViewBuilder
    func getMenuView(for item: MenuItemType) -> some View {
        switch item {
            case .username: getUsernameCell()
            case .userPhoto: getUserPhotoCell()
            case .changeEmail: getChangeEmailCell()
            case .deleteAccount: getDeleteAccountCell()
        }
    }
}

// MARK: - Cells

extension AccountManagerView {
    func getUsernameCell() -> some View {
        HStack(spacing: 10) {
            DagestanTrailsAsset.profileCircle.swiftUIImage
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .foregroundColor(.green)
                .padding(.trailing, Grid.pt16)
            Text("Имя пользователя")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt16))
            Spacer()
            chevron
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(Grid.pt10)
    }

    func getUserPhotoCell() -> some View {
        HStack(spacing: Grid.pt10) {
            DagestanTrailsAsset.imageLinear.swiftUIImage
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .foregroundColor(.green)
                .padding(.trailing, Grid.pt10)
            Text("Фото профиля")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt16))
            Spacer()
            chevron
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(Grid.pt10)
    }

    func getChangeEmailCell() -> some View {
        HStack(spacing: Grid.pt10) {
            DagestanTrailsAsset.smsLinear.swiftUIImage
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .padding(.trailing, Grid.pt10)
            Text("Изменить электронную почту")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt16))
            Spacer()
            chevron
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(Grid.pt10)
    }

    func getDeleteAccountCell() -> some View {
        HStack(spacing: Grid.pt10) {
            DagestanTrailsAsset.profileRemoveLinear.swiftUIImage
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .padding(.trailing, Grid.pt10)
            Text("Удалить аккаунт")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt16))
            Spacer()
            chevron
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(Grid.pt10)
        .onTapGesture {
            self.showAlert = true
        }
        .alert(isPresented: $showAlert) {
            getDeleteAccountAlert()
        }
    }

    func getDeleteAccountAlert() -> Alert {
        Alert(
            title: Text("Ты уверен, что хочешь\n удалить аккаунт?"),
            message: Text("Восстановить данные не получится "),
            primaryButton: .destructive(Text("Удалить")) {
                viewModel.deleteProfile()
            },
            secondaryButton: .cancel(Text("Нет"))
        )
    }
}

// MARK: - MenuItemType

extension AccountManagerView {
    enum MenuItemType: CaseIterable {
        case username
        case userPhoto
        case changeEmail
        case deleteAccount
    }
}

// MARK: - Chevrone

extension AccountManagerView {
    var chevron: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: Grid.pt7, height: Grid.pt12)
            .foregroundColor(WFColor.iconPrimary)
            .bold()
    }
}
