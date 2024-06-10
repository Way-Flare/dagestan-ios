//
//  AuthorizationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 01.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

struct AuthorizationView: View {
    @StateObject var authViewModel = AuthorizationViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    @StateObject var resetViewModel = RegisterViewModel() // - потом придумаю по поводу этого, потому что еще нужно будет хэндлить состояние в RegisterVerificationView для разных вьюмоделей

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
            DagestanKitAsset.bgSurface2.swiftUIColor.ignoresSafeArea()
            
            VStack(spacing: .zero) {
                logoContainerView
                Spacer()
                inputsContainerView
                buttonContainerView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .endEditingOnTap()
    }
    
    private var logoContainerView: some View {
        VStack(spacing: 16) {
            DagestanKitAsset.logo.swiftUIImage
                .resizable()
                .frame(width: 80, height: 64)
                .cornerStyle(.constant(16))
            
            Text("Вход")
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: 32))
        }
        .padding(.top, 12)
    }
    
    private var inputsContainerView: some View {
        VStack(spacing: 12) {
            PhoneMaskTextFieldView(text: $authViewModel.phoneNumber, placeholder: "Номер телефона")
            PasswordTextFieldView(text: $authViewModel.password, placeholder: "Пароль")
        }
        .padding(.bottom, 16)
        .padding(.top, 61)
    }
    
    private var buttonContainerView: some View {
        VStack {
            VStack(spacing: 12) {
                DKButton(
                    title: "Войти",
                    size: .l,
                    state: .default,
                    type: .primary
                ) {
                    Task {
                        await authViewModel.login()
                    }
                }

                DKButton(
                    title: "Забыли пароль?",
                    size: .l,
                    state: .default,
                    type: .nature
                ) {
                    authViewModel.path.append(NavigationRoute.recoveryPassword)
                }
            }
            Spacer()
            
            DKButton(
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
