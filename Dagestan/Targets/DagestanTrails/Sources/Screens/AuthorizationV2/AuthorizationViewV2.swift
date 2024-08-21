//
//  AuthorizationViewV2.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct AuthorizationViewV2: View {
    @StateObject var authViewModel: AuthorizationViewModelV2
    private let service: AuthService

    init(service: AuthService) {
        self.service = service
        self._authViewModel = StateObject(wrappedValue: AuthorizationViewModelV2(authService: service))
    }

    var body: some View {
        NavigationStack(path: $authViewModel.path) {
            contentView
                .navigationDestination(for: AuthNavigationRouteV2.self) { route in
                    switch route {
                        case .verification:
                            VerificationViewV2(authViewModel: authViewModel, path: $authViewModel.path)
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
            DagestanTrailsAsset.logoDark.swiftUIImage
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
        VStack(alignment: .leading, spacing: Grid.pt8) {
            PhoneMaskTextFieldView(text: $authViewModel.phoneNumber, placeholder: "Номер телефона", isError: authViewModel.loginState.isError)
            if let error = authViewModel.loginState.error {
                Text(error)
                    .foregroundStyle(WFColor.errorPrimary)
                    .font(.manropeRegular(size: Grid.pt12))
            }
            Text("Нажимая кнопку войти, вы подтверждаете согласие на [Политику обработки персональных данных](https://dagestan-trails.ru/policyOfConfidentiality)")
                .font(.manropeRegular(size: Grid.pt12))
        }
        .padding(.bottom, Grid.pt16)
        .padding(.top, Grid.pt60)
    }

    private var buttonContainerView: some View {
        VStack {
            WFButton(
                title: "Войти",
                size: .l,
                state: authViewModel.loginState.isLoading ? .loading : .default,
                type: .primary
            ) {
                Task {
                    await authViewModel.auth()
                }
            }
            Spacer()
        }
    }
}
