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
                OTPView(text: $registerViewModel.code, isError: registerViewModel.isFailedValidation) {
                    path.append(NavigationRoute.passwordCreation)
                }

                buttonContainerView
                Spacer()
            }
            .foregroundStyle(WFColor.foregroundSoft)
            .font(.manropeSemibold(size: 16))
            .padding(.horizontal, 16)
            .padding(.top, 34)
            .endEditingOnTap()
        }
    }

    private var enterCodeContainerView: some View {
        VStack(spacing: 16) {
            DagestanTrailsAsset.logo.swiftUIImage
                .resizable()
                .frame(width: 80, height: 64)
                .cornerStyle(.constant(16))

            Text("Введи последние 4 цифры входящего номера")
                .multilineTextAlignment(.center)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeExtrabold(size: 22))
        }
    }

    private var exampleNumberContainerView: some View {
        VStack(spacing: 0) {
            Text("Например: +7 (XXX)-XXX-")
                +
                Text("12-34")
                .foregroundColor(WFColor.accentPrimary)
            Text("Звоним на номер \(FilterNumberPhone.format(phone: registerViewModel.phoneNumber))")
        }
        .padding(.top, 12)
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
        }
        .padding(.top, 4)
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
