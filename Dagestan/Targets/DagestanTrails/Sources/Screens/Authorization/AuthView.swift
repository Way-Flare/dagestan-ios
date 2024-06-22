//
//  AuthorizationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 01.06.2024.
//

import SwiftUI
import DesignSystem
import CoreKit

struct AuthorizationView: View {
    @StateObject var authViewModel = AuthorizationViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    @StateObject var resetViewModel = RegisterViewModel()

    var body: some View {
        NavigationStack(path: $authViewModel.path) {
            contentView
                .navigationDestination(for: NavigationRoute.self) { route in
                    switch route {
                        case .register: RegisterView(viewModel: registerViewModel, path: $authViewModel.path)
                        case .recoveryPassword: RecoveryPasswordView(resetViewModel: resetViewModel, path: $authViewModel.path)
                        case .verification: RegisterVerificationView(registerViewModel: registerViewModel, path: $authViewModel.path)
                        case .passwordCreation: PasswordCreationView(path: $authViewModel.path)
                    }
                }
        }
    }

    private var contentView: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack(spacing: .zero) {
                logoContainerView
                Spacer()
                inputsContainerView
                buttonContainerView
            }
            .padding(.horizontal, Grid.pt16)
            .padding(.vertical, Grid.pt12)
        }
        .endEditingOnTap()
    }

    private var logoContainerView: some View {
        VStack(spacing: Grid.pt16) {
            DagestanTrailsAsset.logo.swiftUIImage
                .resizable()
                .frame(width: Grid.pt80, height: Grid.pt64)
                .cornerStyle(.constant(Grid.pt16))

            Text("Вход")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt32))
        }
        .padding(.top, Grid.pt12)
    }

    private var inputsContainerView: some View {
        VStack(spacing: Grid.pt12) {
            PhoneMaskTextFieldView(text: $authViewModel.phoneNumber, placeholder: "Номер телефона")
            PasswordTextFieldView(text: $authViewModel.password, placeholder: "Пароль")
        }
        .padding(.bottom, Grid.pt16)
        .padding(.top, Grid.pt60)
    }

    private var buttonContainerView: some View {
        VStack {
            VStack(spacing: Grid.pt12) {
                WFButton(
                    title: "Войти",
                    size: .l,
                    state: .default,
                    type: .primary
                ) {
                    Task {
                        await authViewModel.login()
                    }
                }

                WFButton(
                    title: "Забыли пароль?",
                    size: .l,
                    state: .default,
                    type: .nature
                ) {
                    authViewModel.path.append(NavigationRoute.recoveryPassword)
                }
            }
            Spacer()

            WFButton(
                title: "Создать аккаунт",
                size: .l,
                state: .default,
                type: .ghost
            ) {
                authViewModel.path.append(NavigationRoute.register)
            }
        }
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
