//
//  AuthorizationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 01.06.2024.
//

import CoreKit
import DesignSystem
import SwiftUI
import SUINavigation

struct AuthorizationView: View {
    @StateObject var authViewModel: AuthorizationViewModel
    @StateObject var registerViewModel: RegisterViewModel
    @StateObject var resetViewModel: RegisterViewModel

    private let service: AuthService

    init(service: AuthService) {
        self.service = service
        self._authViewModel = StateObject(wrappedValue: AuthorizationViewModel(authService: service))
        self._registerViewModel = StateObject(wrappedValue: RegisterViewModel(authService: service))
        self._resetViewModel = StateObject(wrappedValue: RegisterViewModel(isRecovery: true, authService: service))
    }

    var body: some View {
        NavigationStack(path: $authViewModel.path) {
            contentView
                .navigationDestination(for: AuthNavigationRoute.self) { route in
                    switch route {
                        case .register:
                            RegisterView(viewModel: registerViewModel, path: $authViewModel.path)
                        case .recoveryPassword:
                            RecoveryPasswordView(viewModel: resetViewModel, path: $authViewModel.path)
                        case let .verification(isRecovery):
                            RegisterVerificationView(
                                registerViewModel: isRecovery ? resetViewModel : registerViewModel,
                                path: $authViewModel.path
                            )
                        case let .passwordCreation(phone):
                            PasswordCreationView(service: service, phone: phone, path: $authViewModel.path)
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
            PhoneMaskTextFieldView(text: $authViewModel.phoneNumber, placeholder: "Номер телефона", isError: authViewModel.state.isError)
            VStack(alignment: .leading, spacing: Grid.pt8) {
                PasswordTextFieldView(text: $authViewModel.password, placeholder: "Пароль", isError: authViewModel.state.isError)
                if let error = authViewModel.state.error {
                    Text(error)
                        .foregroundStyle(WFColor.errorPrimary)
                        .font(.manropeRegular(size: Grid.pt12))
                }
            }
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
                    state: authViewModel.state.isLoading ? .loading : .default,
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
                    authViewModel.path.append(AuthNavigationRoute.recoveryPassword)
                }
            }
            Spacer()

            WFButton(
                title: "Создать аккаунт",
                size: .l,
                state: .default,
                type: .ghost
            ) {
                authViewModel.path.append(AuthNavigationRoute.register)
            }
        }
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
