//
//  RegisterView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit
import DesignSystem
import SwiftUI

struct RegisterView<RegisterViewModel: IRegisterViewModel>: View {
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
            DagestanTrailsAsset.logoDark.swiftUIImage
                .resizable()
                .frame(width: Grid.pt80, height: Grid.pt64)
                .cornerStyle(.constant(Grid.pt16))

            Text("Регистрация")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt32))
        }
        .padding(.top, Grid.pt12)
    }

    private var inputContainerView: some View {
        VStack(alignment: .leading) {
            PhoneMaskTextFieldView(
                text: $viewModel.phoneNumber,
                placeholder: "Номер телефона",
                isError: viewModel.registrationState.isError
            )

            if let error = viewModel.registrationState.error {
                Text(error)
                    .foregroundStyle(WFColor.errorPrimary)
                    .font(.manropeRegular(size: Grid.pt14))
            }
            // Чекбокс для согласия на обработку персональных данных
            Toggle(isOn: $viewModel.isPrivacyPolicyAccepted) {
                Text("Я подтверждаю согласие на [Политику обработки персональных данных](https://dagestan-trails.ru)")
                    .font(.manropeRegular(size: Grid.pt12))
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding(.horizontal, Grid.pt8)
        }
        .padding(.bottom, Grid.pt16)
        .padding(.top, Grid.pt44)
    }

    private var buttonContainerView: some View {
        VStack {
            WFButton(
                title: "Зарегистрироваться",
                size: .l,
                state: buttonState(),
                type: .primary
            ) {
                Task {
                    await viewModel.performAuthRequest()

                    if !viewModel.registrationState.isError {
                        path.append(AuthNavigationRoute.verification(isRecovery: false))
                    }
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

    private func buttonState() -> WFButtonState {
        if viewModel.registrationState.isLoading {
            return .loading
        }
        if viewModel.isPrivacyPolicyAccepted, viewModel.phoneNumber.count >= 11 {
            return .default
        }

        return .disabled
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(WFColor.iconAccent)
                .frame(width: Grid.pt24, height: Grid.pt24)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
