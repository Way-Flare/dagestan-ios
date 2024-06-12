//
//  RecoveryPasswordView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import SwiftUI
import DesignSystem
import CoreKit

struct RecoveryPasswordView: View {
    @ObservedObject var resetViewModel: RegisterViewModel
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

    private var createPasswordContainerView: some View {
        Text("Сброс пароля")
            .multilineTextAlignment(.center)
            .foregroundStyle(WFColor.foregroundPrimary)
            .font(.manropeExtrabold(size: Grid.pt22))
    }

    private var inputsContainerView: some View {
        PhoneMaskTextFieldView(
            text: $resetViewModel.phoneNumber,
            placeholder: "Номер телефона"
        )
        .padding(.top, Grid.pt12)
    }

    private var nextButton: some View {
        WFButton(
            title: "Далее",
            size: .l,
            state: resetViewModel.phoneNumber.count <= 10 ? .disabled : .default,
            type: .primary
        ) {
            path.append(NavigationRoute.verification)
        }
        .padding(.top, Grid.pt4)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
