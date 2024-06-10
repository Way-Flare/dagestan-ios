//
//  RegisterView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @Binding var path: NavigationPath

    var body: some View {
        contentView
            .setCustomBackButton()
    }

    private var contentView: some View {
        ZStack {
            DagestanKitAsset.bgSurface2.swiftUIColor.ignoresSafeArea()

            VStack(spacing: .zero) {
                logoContainerView
                inputContainerView
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

            Text("Регистрация")
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: 32))
        }
        .padding(.top, 12)
    }

    private var inputContainerView: some View {
        PhoneMaskTextFieldView(
            text: $viewModel.phoneNumber,
            placeholder: "Номер телефона"
        )
        .padding(.bottom, 16)
        .padding(.top, 44)
    }

    private var buttonContainerView: some View {
        VStack {
            DKButton(
                title: "Зарегистрироваться",
                size: .l,
                state: viewModel.phoneNumber.count >= 11 ? .default : .disabled,
                type: .primary
            ) {
                Task {
                    await viewModel.register()
                }

                if !viewModel.isFailedValidation {
                    path.append(NavigationRoute.verification)
                }
            }
            Spacer()

            DKButton(
                title: "Уже есть аккаунт? Войти",
                size: .l,
                state: .default,
                type: .ghost
            ) {
                path.removeLast()
            }
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
