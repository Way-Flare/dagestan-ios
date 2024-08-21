//
//  VerificationViewV2.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct VerificationViewV2<AuthViewModel: IAuthorizationViewModelV2>: View {
    @EnvironmentObject private var timerViewModel: TimerViewModel
    @ObservedObject var authViewModel: AuthViewModel
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
                OTPView(text: $authViewModel.code, isError: authViewModel.confirmVerification.isError == true) {
                    Task {
                        await authViewModel.confirmSmsVerification()

                        if !authViewModel.confirmVerification.isError {
                            path.removeLast(path.count)
                        }
                    }               
                }

                buttonContainerView
                Spacer()
            }
            .onAppear {
                timerViewModel.startTimer()
                Task {
                    await authViewModel.sendSmsVerification()
                }
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
            DagestanTrailsAsset.logoDark.swiftUIImage
                .resizable()
                .frame(width: Grid.pt80, height: Grid.pt64)
                .cornerStyle(.constant(Grid.pt16))

            Text("Введи код из СМС")
                .multilineTextAlignment(.center)
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeExtrabold(size: Grid.pt22))
        }
    }

    private var buttonContainerView: some View {
        WFButton(
            title: "Запросить СМС код заново",
            size: .l,
            state: timerViewModel.timerIsActive ? .disabled : .default,
            type: .primary,
            subtitle: timerViewModel.subtitle
        ) {
            timerViewModel.startTimer()
            Task {
                await authViewModel.sendSmsVerification()
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
