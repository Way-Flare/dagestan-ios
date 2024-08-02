//
//  ProfileView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

struct ProfileView: View {
    @AppStorage("isAuthorized") var isAuthorized = false
    @State private var showingAlert = false
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var feedbackViewModel: MyReviewsViewModel

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
                        .offset(y: -Grid.pt24)
                }
            }
            .coordinateSpace(name: "pullToResize")
            .ignoresSafeArea()
            .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
            .onAppear {
                if viewModel.profileState.data == nil {
                    viewModel.loadProfile()
                }
            }
        }
    }

    private var profileCircle: some View {
        VStack(spacing: Grid.pt8) {
            getUserPhotoImageView()

            if let username = viewModel.profileState.data?.username {
                Text(username)
                    .foregroundColor(WFColor.foregroundPrimary)
                    .font(.manropeSemibold(size: Grid.pt18))
            } else {
                makeRectangle()
            }
            if let email = viewModel.profileState.data?.email {
                Text(email)
                    .foregroundColor(WFColor.foregroundSoft)
                    .font(.manropeSemibold(size: Grid.pt18))
            }
        }
        .offset(y: -Grid.pt65)
    }

    private func makeRectangle() -> some View {
        Rectangle()
            .fill()
            .frame(width: 62, height: 34)
            .skeleton()
            .cornerStyle(.constant(Grid.pt8))
            .alert("Не удалось загрузить данные", isPresented: $viewModel.isShowAlert) {
                Button("Да", role: .cancel) {
                    viewModel.loadProfile()
                }
                Button("Нет", role: .destructive) {}
            } message: {
                Text("Повторить попытку?")
            }
    }

    private var menuSection: some View {
        VStack(spacing: Grid.pt10) {
            ForEach(MenuItemType.allCases, id: \.self) { item in
                NavigationLink(destination: getDestination(for: item)) {
                    getMenuView(for: item)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Grid.pt108)
        .padding(.horizontal, Grid.pt12)
        .background(WFColor.surfaceSecondary)
        .cornerRadius(Grid.pt24)
    }
}

// MARK: - Menu

extension ProfileView {
    @ViewBuilder
    func getDestination(for item: MenuItemType) -> some View {
        switch item {
            case .reviews: MyReviewsView(profile: viewModel.profileState.data).environmentObject(feedbackViewModel)
            case .account: AccountManagerView(avatar: viewModel.profileState.data?.avatar).environmentObject(viewModel)
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
        HStack(spacing: Grid.pt10) {
            DagestanTrailsAsset.starOutline.swiftUIImage
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .padding(.trailing, Grid.pt10)
                .foregroundColor(.green)
            Text("Мои отзывы")
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

    func getAccountCell() -> some View {
        HStack(spacing: Grid.pt10) {
            DagestanTrailsAsset.profileCircle.swiftUIImage
                .resizable()
                .frame(width: Grid.pt28, height: Grid.pt28)
                .padding(.trailing, Grid.pt10).foregroundColor(.green)
            Text("Управление аккаунтом")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: Grid.pt16))
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
            HStack(spacing: Grid.pt10) {
                DagestanTrailsAsset.logout.swiftUIImage
                    .resizable()
                    .frame(width: Grid.pt28, height: Grid.pt28)
                    .padding(.trailing, Grid.pt10).foregroundColor(.green)
                Text("Выйти")
                    .foregroundColor(WFColor.foregroundPrimary)
                    .font(.manropeRegular(size: Grid.pt16))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(WFColor.surfacePrimary)
        .cornerRadius(Grid.pt10)
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
            .frame(width: Grid.pt7, height: Grid.pt12)
            .foregroundColor(WFColor.iconPrimary)
            .bold()
    }

    var person: some View {
        Image(systemName: "person")
            .resizable()
            .frame(width: Grid.pt28, height: Grid.pt28)
            .foregroundStyle(WFColor.iconSoft)
    }

    @ViewBuilder
    func getUserPhotoImageView() -> some View {
        if viewModel.profileState.isLoading {
            ShimmerCircleView()
        } else {
            if let url = viewModel.profileState.data?.avatar {
                LazyImage(url: url) { state in
                    if state.isLoading {
                        ShimmerCircleView()
                    } else if let image = state.image {
                        state.image?
                            .resizable()
                            .frame(width: Grid.pt96, height: Grid.pt96)
                            .overlay(
                                Circle()
                                    .strokeBorder(WFColor.surfaceSecondary, lineWidth: Grid.pt2)
                            )
                            .clipShape(Circle())
                            .shadow(radius: Grid.pt10)
                    }
                }
            } else {
                Circle()
                    .fill(WFColor.surfacePrimary)
                    .frame(width: Grid.pt96, height: Grid.pt96)
                    .overlay(person)
                    .overlay(
                        Circle()
                            .strokeBorder(WFColor.surfaceSecondary, lineWidth: Grid.pt2)
                    )
            }
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
