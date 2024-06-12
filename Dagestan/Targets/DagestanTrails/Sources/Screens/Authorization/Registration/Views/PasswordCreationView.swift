//
//  PasswordCreationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import Combine
import SwiftUI
import CoreKit
import DesignSystem

struct PasswordCreationView: View {
    @StateObject private var viewModel = PasswordViewModel()
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack(spacing: Grid.pt12) {
                createPasswordContainerView
                inputsContainerView
                requirementsContainerView
                nextButton
                Spacer()
            }
            .padding([.horizontal, .top], 16)
            .setCustomBackButton()
            .alert("Ошибка", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                coincidenceContainerView
            }
        }
    }

    private var coincidenceContainerView: some View {
        Text("Введенные пароли не совпадают. Пожалуйста, проверьте и попробуйте снова.")
            .foregroundStyle(WFColor.foregroundPrimary)
            .font(.manropeRegular(size: 20))
            .multilineTextAlignment(.center)
    }

    private var createPasswordContainerView: some View {
        Text("Придумай пароль")
            .multilineTextAlignment(.center)
            .foregroundStyle(WFColor.foregroundPrimary)
            .font(.manropeExtrabold(size: 22))
    }

    private var inputsContainerView: some View {
        VStack(spacing: 12) {
            PasswordTextFieldView(text: $viewModel.password, placeholder: "Придумай пароль")
            PasswordTextFieldView(text: $viewModel.confirmPassword, placeholder: "Повтори пароль")
        }
        .padding(.top, 12)
    }

    private var requirementsContainerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(viewModel.validationRules.indices, id: \.self) { index in
                ValidationRow(rule: viewModel.validationRules[index])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var nextButton: some View {
        WFButton(
            title: "Далее",
            size: .l,
            state: viewModel.isButtonDisabled ? .disabled : .default,
            type: .primary
        ) {
            if viewModel.password == viewModel.confirmPassword {
                path.removeLast(path.count)
            } else {
                viewModel.showAlert = true
            }
        }
        .padding(.top, 4)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
