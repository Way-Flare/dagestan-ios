//
//  OTPView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct OTPView: View {
    @Binding var text: String
    @FocusState var isKeyboardShowing
    
    private let isError: Bool
    private let action: (() -> Void)?
    
    init(
        text: Binding<String>,
        isError: Bool,
        action: (() -> Void)? = nil
    ) {
        self._text = text
        self.isError = isError
        self.action = action
    }

    var body: some View {
        otpNumber
    }
}

private extension OTPView {
    var otpNumber: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ForEach(0 ..< 4, id: \.self) { index in
                    OTPTextBox(index)
                }
            }
            errorText
        }
        .background {
            TextField("", text: $text.limit(4))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 1, height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
                .onChange(of: text) { newValue in
                    if newValue.count == 4 && !isError {
                        action?()
                    }
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing.toggle()
        }
        .onAppear {
            isKeyboardShowing = true
        }
        .navigationBarBackButtonHidden()
        
    }
    
    @ViewBuilder var errorText: some View {
        if isError {
            Text("Неверный код. Попробуйте еще раз")
                .foregroundStyle(DagestanKitAsset.errorDefault.swiftUIColor)
                .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 12))
        }
    }

    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            Text(characterAt(index))
                .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(DagestanKitAsset.fgDefault.swiftUIColor)
        }
        .frame(width: 44, height: 44)
        .overlay(borderForIndex(index))
        .overlay(indicatorForIndex(index))
        .background(
            isError
            ? DagestanKitAsset.errorContainerDefault.swiftUIColor
            : DagestanKitAsset.bgSurface1.swiftUIColor
        )
        .cornerStyle(.constant(8))
    }

    private func characterAt(_ index: Int) -> String {
        guard text.count > index else { return " " }
        return String(text[text.index(text.startIndex, offsetBy: index)])
    }

    private func borderForIndex(_ index: Int) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(
                isError
                ? DagestanKitAsset.errorDefault.swiftUIColor
                : text.count >= index
                  ? DagestanKitAsset.accentDefault.swiftUIColor
                  : DagestanKitAsset.borderMuted.swiftUIColor,
                lineWidth: 1
            )
    }

    private func indicatorForIndex(_ index: Int) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 2, height: 20)
            .foregroundColor(DagestanKitAsset.accentDefault.swiftUIColor)
            .offset(x: -9)
            .isHidden(text.count != index || isError)
    }
}

#Preview {
    OTPView(text: .constant("some"), isError: true)
}
