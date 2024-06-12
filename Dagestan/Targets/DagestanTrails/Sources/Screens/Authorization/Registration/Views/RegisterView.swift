//
//  RegisterView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import SwiftUI
import DesignSystem
import CoreKit

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @Binding var path: NavigationPath

    var body: some View {
        contentView
            .setCustomBackButton()
    }

    private var contentView: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack(spacing: .zero) {
                logoContainerView
                inputContainerView
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
                .frame(width: 80, height: 64)
                .cornerStyle(.constant(16))

            Text("Регистрация")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt32))
        }
        .padding(.top, Grid.pt12)
    }

    private var inputContainerView: some View {
        PhoneMaskTextFieldView(
            text: $viewModel.phoneNumber,
            placeholder: "Номер телефона"
        )
        .padding(.bottom, Grid.pt16)
        .padding(.top, Grid.pt44)
    }

    private var buttonContainerView: some View {
        VStack {
            WFButton(
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

            WFButton(
                title: "Уже есть аккаунт? Войти",
                size: .l,
                state: .default,
                type: .ghost
            ) {
                path.removeLast()
            }
        }
        .padding(.bottom, Grid.pt8)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
