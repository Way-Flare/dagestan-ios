//
//  RecoveryPasswordView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct RecoveryPasswordView: View {
    @ObservedObject var resetViewModel: RegisterViewModel
    @Binding var path: NavigationPath

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            DagestanKitAsset.bgSurface2.swiftUIColor.ignoresSafeArea()
            VStack(spacing: 12) {
                createPasswordContainerView
                inputsContainerView
                nextButton
                Spacer()
            }
            .padding([.horizontal, .top], 16)
            .setCustomBackButton()
        }
    }

    private var createPasswordContainerView: some View {
        Text("Сброс пароля")
            .multilineTextAlignment(.center)
            .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
            .font(DagestanKitFontFamily.Manrope.extraBold.swiftUIFont(size: 22))
    }

    private var inputsContainerView: some View {
        PhoneMaskTextFieldView(
            text: $resetViewModel.phoneNumber,
            placeholder: "Номер телефона"
        )
        .padding(.top, 12)
    }

    private var nextButton: some View {
        DKButton(
            title: "Далее",
            size: .l,
            state: resetViewModel.phoneNumber.count <= 10 ? .disabled : .default,
            type: .primary
        ) {
            path.append(NavigationRoute.verification)
        }
        .padding(.top, 4)
    }
}

#Preview {
    ContentView(networkService: DTNetworkService())
        .environmentObject(TimerViewModel())
}
