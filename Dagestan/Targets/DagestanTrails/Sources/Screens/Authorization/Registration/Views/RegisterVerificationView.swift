//
//  RegisterVerificationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import Combine
import CoreKit
import DesignSystem
import SwiftUI

struct RegisterVerificationView: View {
    @EnvironmentObject private var timerViewModel: TimerViewModel
    @ObservedObject var registerViewModel: RegisterViewModel
    @Binding var path: NavigationPath

    var body: some View {
        contentView
            .setCustomBackButton()
    }

    private var contentView: some View {
        ZStack {
            WFColor.surfaceSecondary.ignoresSafeArea()
            VStack(spacing: Grid.pt12) {
                enterCodeContainerView
                exampleNumberContainerView
                OTPView(text: $registerViewModel.code, isError: registerViewModel.verificationState.error != nil) {
                    Task {
                        await registerViewModel.performVerificationRequest()
                        if !registerViewModel.verificationState.isError {
                            path.append(NavigationRoute.passwordCreation(phone: registerViewModel.phoneNumber))
                        }
                    }
                }

                buttonContainerView
                Spacer()
            }
            .foregroundStyle(WFColor.foregroundSoft)
            .font(.manropeSemibold(size: Grid.pt16))
            .padding(.horizontal, Grid.pt16)
            .padding(.top, Grid.pt34)
            .endEditingOnTap()
        }
    }

    private var enterCodeContainerView: some View {
        VStack(spacing: Grid.pt16) {
            DagestanTrailsAsset.logo.swiftUIImage
                .resizable()
                .frame(width: Grid.pt80, height: Grid.pt64)
                .cornerStyle(.constant(Grid.pt16))

            Text("Введи последние 4 цифры входящего номера")
                .multilineTextAlignment(.center)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeExtrabold(size: Grid.pt22))
        }
    }

    private var exampleNumberContainerView: some View {
        VStack(spacing: .zero) {
            Text("Например: +7 (XXX)-XXX-")
                +
                Text("12-34")
                .foregroundColor(WFColor.accentPrimary)
            Text("Звоним на номер \(FilterNumberPhone.format(phone: registerViewModel.phoneNumber))")
        }
        .padding(.top, Grid.pt12)
    }

    private var buttonContainerView: some View {
        WFButton(
            title: "Запросить СМС-код",
            size: .l,
            state: timerViewModel.timerIsActive ? .disabled : .default,
            type: .primary,
            subtitle: timerViewModel.subtitle
        ) {
            timerViewModel.startTimer()
            Task {
                await registerViewModel.performAuthRequest()
            }
        }
        .padding(.top, Grid.pt4)
    }

    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
