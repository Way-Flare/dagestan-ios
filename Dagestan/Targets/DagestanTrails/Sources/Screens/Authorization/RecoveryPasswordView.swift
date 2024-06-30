//
//  RecoveryPasswordView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit
import DesignSystem
import SwiftUI

struct RecoveryPasswordView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @Binding var path: NavigationPath

    var body: some View {
        contentView
    }

    private var contentView: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack(spacing: Grid.pt12) {
                createPasswordContainerView
                inputsContainerView
                nextButton
                Spacer()
            }
            .padding([.horizontal, .top], Grid.pt16)
            .setCustomBackButton()
        }
    }

    // TODO: DAGESTAN-200
    private var createPasswordContainerView: some View {
        Text("Сброс пароля")
            .multilineTextAlignment(.center)
            .foregroundStyle(WFColor.foregroundPrimary)
            .font(.manropeExtrabold(size: Grid.pt22))
    }

    // TODO: DAGESTAN-200
    private var inputsContainerView: some View {
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
        }
        .padding(.top, Grid.pt12)
    }

    // TODO: DAGESTAN-200
    private var nextButton: some View {
        WFButton(
            title: "Далее", // TODO: DAGESTAN-200
            size: .l,
            state: viewModel.registrationState.isLoading ? .loading : viewModel.phoneNumber.count >= 11 ? .default : .disabled,
            type: .primary
        ) {
            Task {
                await viewModel.performAuthRequest()

                if !viewModel.registrationState.isError {
                    path.append(NavigationRoute.verification(isRecovery: true))
                }
            }
        }
        .padding(.top, Grid.pt4)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
