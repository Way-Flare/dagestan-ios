//
//  OTPView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.06.2024.
//

import SwiftUI
import DesignSystem

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
        VStack(spacing: Grid.pt8) {
            HStack(spacing: Grid.pt8) {
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
                .frame(width: Grid.pt1, height: Grid.pt1)
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

    // TODO: DAGESTAN-200
    @ViewBuilder var errorText: some View {
        if isError {
            Text("Неверный код. Попробуйте еще раз")
                .foregroundStyle(WFColor.errorPrimary)
                .font(.manropeRegular(size: Grid.pt12))
        }
    }

    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            Text(characterAt(index))
                .font(.manropeRegular(size: Grid.pt16))
                .multilineTextAlignment(.center)
                .foregroundStyle(WFColor.foregroundPrimary)
        }
        .frame(width: Grid.pt44, height: Grid.pt44)
        .overlay(borderForIndex(index))
        .overlay(indicatorForIndex(index))
        .background(
            isError
            ? WFColor.errorContainerPrimary
            : WFColor.surfacePrimary
        )
        .cornerStyle(.constant(Grid.pt8))
    }

    private func characterAt(_ index: Int) -> String {
        guard text.count > index else { return " " }
        return String(text[text.index(text.startIndex, offsetBy: index)])
    }

    private func borderForIndex(_ index: Int) -> some View {
        RoundedRectangle(cornerRadius: Grid.pt8)
            .stroke(
                isError
                ? WFColor.errorPrimary
                : text.count >= index
                  ? WFColor.accentPrimary
                  : WFColor.borderMuted,
                lineWidth: Grid.pt1
            )
    }

    private func indicatorForIndex(_ index: Int) -> some View {
        RoundedRectangle(cornerRadius: Grid.pt8)
            .frame(width: Grid.pt2, height: Grid.pt20)
            .foregroundColor(WFColor.accentPrimary)
            .offset(x: -Grid.pt9)
            .isHidden(text.count != index || isError)
    }
}

#Preview {
    OTPView(text: .constant("some"), isError: true)
}
