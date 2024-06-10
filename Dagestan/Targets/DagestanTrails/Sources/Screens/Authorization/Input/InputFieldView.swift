import Foundation
import SwiftUI

struct InputFieldView: View {
    @Binding var text: String
    @Binding var isFailedValidation: Bool

    let placeholder: String
    var isSecure = false
    @State private var showPassword = false
    @State private var localText: String = ""
    @State private var isEditing = false

    var body: some View {
        HStack {
            textFieldContainerView
            eyeButtonContainerView
        }
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .padding(12)
        .background(colorBackgroundForState)
        .setBorder(
            width: 1,
            color: colorBorderForState
        )
        .onTapGesture {
            self.isEditing = true
        }
        .onDisappear {
            self.isEditing = false
        }
    }
    
    private var textFieldContainerView: some View {
        ZStack(alignment: .leading) {
            if localText.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
            }

            if isSecure && !showPassword {
                SecureField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: textFieldBinding)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(isSecure ? .default : .numberPad)
            }
        }
    }
    
    private var textFieldBinding: Binding<String> {
        Binding(
            get: {
                self.localText
            },
            set: {
                self.localText = $0
                if !isSecure {
                    let formattedText = formatPhoneNumber(phoneNumber: $0)
                    if formattedText != self.localText {
                        self.localText = formattedText
                    }
                    self.text = extractDigits(from: formattedText)
                } else {
                    self.text = $0
                }
            }
        )
    }
    
    @ViewBuilder private var eyeButtonContainerView: some View {
        if isSecure {
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.primary)
            }
        }
    }
    
    private var colorBorderForState: Color {
        if isFailedValidation {
            return .red
        } else if isEditing {
            return .blue
        } else {
            return .gray.opacity(0.5)
        }
    }
    
    private var colorBackgroundForState: Color {
        if isFailedValidation {
            return Color.red.opacity(0.1)
        } else {
            return Color.clear
        }
    }
    
    private func formatPhoneNumber(phoneNumber: String) -> String {
        let digits = extractDigits(from: phoneNumber)
        let formatted = digits.applyPhoneNumberMask()
        return formatted
    }
    
    private func extractDigits(from input: String) -> String {
        return input.filter { $0.isNumber }
    }
}

extension String {
    func applyPhoneNumberMask() -> String {
        let digits = self
        var result = ""
        let mask = "+X (XXX) XXX-XX-XX"
        var index = digits.startIndex
        for ch in mask where index < digits.endIndex {
            if ch == "X" {
                result.append(digits[index])
                index = digits.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

#Preview {
    InputFieldView(text: .constant(""), isFailedValidation: .constant(false), placeholder: "Номер телефона")
}
