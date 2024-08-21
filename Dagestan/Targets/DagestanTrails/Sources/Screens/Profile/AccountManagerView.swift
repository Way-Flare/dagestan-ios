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
    @ObservedObject var viewModel: ProfileViewModel
    let profile: Profile

    var body: some View {
        VStack(spacing: Grid.pt10) {
            ForEach(MenuItemType.allCases, id: \.self) { item in
                NavigationLink(destination: getDestination(for: item)) {
                    getMenuView(for: item)
                }
                .buttonStyle(.plain)
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
            case .userPhoto: UserChangePhotoView(viewModel: viewModel, username: profile.username, avatar: profile.avatar)
            case .changeEmail: UsernameChangeView(isUserChange: false, placeholder: "Введите почту", viewModel: viewModel)
            case .changeBackgroundPhoto:
                if let profile = viewModel.profileState.data {
                    ProfileChangeBackgroundImageView(profile: profile)
                }
            case .deleteAccount: EmptyView()
        }
    }

    @ViewBuilder
    func getMenuView(for item: MenuItemType) -> some View {
        switch item {
            case .deleteAccount: getDeleteAccountCell()
            default: setupBasicCell(for: item)
        }
    }
}

// MARK: - Cells

extension AccountManagerView {
    func getDeleteAccountCell() -> some View {
        setupBasicCell(for: .deleteAccount)
            .onTapGesture {
                self.showAlert = true
            }
            .alert(isPresented: $showAlert) {
                getDeleteAccountAlert()
            }
    }

    private func setupBasicCell(for item: MenuItemType) -> some View {
        HStack(spacing: Grid.pt10) {
            item.icon
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .padding(.trailing, Grid.pt10)
                .foregroundStyle(WFColor.accentPrimary)
            Text(item.title)
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt16))
            Spacer()
            if item.hasChevron {
                chevron
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(Grid.pt10)
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
        case changeBackgroundPhoto
        case deleteAccount
        
        var title: String {
            switch self {
                case .username: return "Имя пользователя"
                case .userPhoto: return "Фото профиля"
                case .changeEmail: return "Изменить электронную почту"
                case .changeBackgroundPhoto: return "Поменять задний фон"
                case .deleteAccount: return "Удалить аккаунт"
            }
        }
        
        var icon: Image {
            switch self {
                case .username: DagestanTrailsAsset.profileCircle.swiftUIImage
                case .userPhoto: DagestanTrailsAsset.imageLinear.swiftUIImage
                case .changeEmail: DagestanTrailsAsset.smsLinear.swiftUIImage
                case .changeBackgroundPhoto: DagestanTrailsAsset.imageLinear.swiftUIImage
                case .deleteAccount: DagestanTrailsAsset.profileRemoveLinear.swiftUIImage
            }
        }
        
        var hasChevron: Bool {
            self != .deleteAccount
        }
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
