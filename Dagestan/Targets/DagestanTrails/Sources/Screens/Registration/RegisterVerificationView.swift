//
//  RegisterVerificationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Combine
import DagestanKit
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
            DagestanKitAsset.bgSurface2.swiftUIColor.ignoresSafeArea()

            VStack(spacing: 12) {
                enterCodeContainerView
                exampleNumberContainerView
                OTPView(text: $registerViewModel.code, isError: registerViewModel.isFailedValidation) {
                    path.append(NavigationRoute.passwordCreation)
                }

                buttonContainerView
                Spacer()
            }
            .foregroundStyle(DagestanKitAsset.fgSoft.swiftUIColor)
            .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: 16))
            .padding(.horizontal, 16)
            .padding(.top, 34)
            .endEditingOnTap()
        }
    }

    private var enterCodeContainerView: some View {
        VStack(spacing: 16) {
            DagestanKitAsset.logo.swiftUIImage
                .resizable()
                .frame(width: 80, height: 64)
                .cornerStyle(.constant(16))

            Text("Введи последние 4 цифры входящего номера")
                .multilineTextAlignment(.center)
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.extraBold.swiftUIFont(size: 22))
        }
    }

    private var exampleNumberContainerView: some View {
        VStack(spacing: 0) {
            Text("Например: +7 (XXX)-XXX-")
                +
                Text("12-34")
                .foregroundColor(DagestanKitAsset.accentDefault.swiftUIColor)
            Text("Звоним на номер \(FilterNumberPhone.format(phone: registerViewModel.phoneNumber))")
        }
        .padding(.top, 12)
    }

    private var buttonContainerView: some View {
        DKButton(
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
