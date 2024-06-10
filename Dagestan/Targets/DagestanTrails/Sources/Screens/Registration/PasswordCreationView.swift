//
//  PasswordCreationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Combine
import DagestanKit
import SwiftUI

struct PasswordCreationView: View {
    @StateObject private var viewModel = PasswordViewModel()
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            DagestanKitAsset.bgSurface2.swiftUIColor.ignoresSafeArea()
            VStack(spacing: 12) {
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
            .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
            .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 20))
            .multilineTextAlignment(.center)
    }

    private var createPasswordContainerView: some View {
        Text("Придумай пароль")
            .multilineTextAlignment(.center)
            .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
            .font(DagestanKitFontFamily.Manrope.extraBold.swiftUIFont(size: 22))
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
        DKButton(
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
