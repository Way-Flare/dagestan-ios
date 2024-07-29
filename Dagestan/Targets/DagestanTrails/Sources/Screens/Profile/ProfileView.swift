//
//  ProfileView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import NukeUI

struct ProfileView: View {
    @AppStorage("isAuthorized") var isAuthorized = false
    @State private var showingAlert = false
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ScrollViewWithScrollOffset(scrollOffset: $viewModel.offset) {
                VStack(spacing: .zero) {
                    ProfileImageView(offset: $viewModel.offset)
                    menuSection
                        .overlay(
                            profileCircle,
                            alignment: .top
                        )
                        .offset(y: -24)
                }
            }
            .coordinateSpace(name: "pullToResize")
            .ignoresSafeArea()
            .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
        }
    }

    private var profileCircle: some View {
        VStack(spacing: 8) {
            getUserPhotoImageView()

            Text(viewModel.profileState.data?.username ?? "[username]")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: 18))
        }
        .offset(y: -65)
    }

    private var menuSection: some View {
        VStack(spacing: 10) {
            ForEach(MenuItemType.allCases, id: \.self) { item in
                NavigationLink(destination: getDestination(for: item)) {
                    getMenuView(for: item)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 79)
        .padding(.horizontal, 12)
        .background(WFColor.surfaceSecondary)
        .cornerRadius(12)
    }
}

// MARK: - Menu

extension ProfileView {
    @ViewBuilder
    func getDestination(for item: MenuItemType) -> some View {
        switch item {
            case .reviews: Text("Some")
            case .account: AccountManagerView(viewModel: viewModel)
            case .logout: EmptyView()
        }
    }

    @ViewBuilder
    func getMenuView(for item: MenuItemType) -> some View {
        switch item {
            case .reviews: getReviewsCell()
            case .account: getAccountCell()
            case .logout: getLogoutCell()
        }
    }
}
// MARK: - Cells

extension ProfileView {
    func getReviewsCell() -> some View {
        HStack(spacing: 10) {
            DagestanTrailsAsset.starOutline.swiftUIImage
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.trailing, 10)
                .foregroundColor(.green)
            Text("Мои отзывы")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: 16))
            Spacer()
            chevron
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(10)
    }

    func getAccountCell() -> some View {
        HStack(spacing: 10) {
            DagestanTrailsAsset.profileCircle.swiftUIImage
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.trailing, 10).foregroundColor(.green)
            Text("Управление аккаунтом")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: 16))
            Spacer()
            chevron
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(10)
    }

    func getLogoutCell() -> some View {
        Button {
            showingAlert = true
        } label: {
            HStack(spacing: 10) {
                DagestanTrailsAsset.logout.swiftUIImage
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.trailing, 10).foregroundColor(.green)
                Text("Выйти")
                    .foregroundColor(WFColor.foregroundPrimary)
                    .font(.manropeRegular(size: 16))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(WFColor.surfacePrimary)
        .cornerRadius(10)
        .alert(isPresented: $showingAlert) {
            getAlert()
        }
    }
}

extension ProfileView {
    func getAlert() -> Alert {
        Alert(
            title: Text("Выход"),
            message: Text("Вы уверены, что хотите выйти из аккаунта?"),
            primaryButton: .destructive(Text("Выйти")) {
                isAuthorized = false
            },
            secondaryButton: .cancel()
        )
    }
}

extension ProfileView {
    var chevron: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 7, height: 12)
            .foregroundColor(WFColor.iconPrimary)
            .bold()
    }
    
    var person: some View {
        Image(systemName: "person")
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundStyle(WFColor.iconSoft)
    }
    
    @ViewBuilder
    func getUserPhotoImageView() -> some View {
        if let url = viewModel.profileState.data?.avatar {
            LazyImage(url: url)
                .frame(width: 96, height: 96)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(
                    Circle()
                        .strokeBorder(WFColor.surfaceSecondary, lineWidth: 2)
                )
        } else {
            Circle()
                .fill(WFColor.surfacePrimary)
                .frame(width: 96, height: 96)
                .overlay(person)
                .overlay(
                    Circle()
                        .strokeBorder(WFColor.surfaceSecondary, lineWidth: 2)
                )
        }
    }
}

extension ProfileView {
    enum MenuItemType: CaseIterable {
        case reviews
        case account
        case logout
    }
}

#Preview {
    ProfileView()
}
