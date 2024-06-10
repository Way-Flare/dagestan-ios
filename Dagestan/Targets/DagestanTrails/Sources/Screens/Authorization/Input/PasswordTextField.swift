import SwiftUI
import DagestanKit

struct PasswordTextFieldView: View {
    @State private var showPassword = false
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var placeholder: String
    var isError = false
    var isSecure = true
    
    var body: some View {
        ZStack {
            SecureField(placeholder, text: $text)
                .textContentType(.oneTimeCode)
                .opacity(isSecure && !showPassword ? 1 : 0)

            TextField(placeholder, text: $text)
                .opacity(isSecure && !showPassword ? 0 : 1)
        }
        .focused($isFocused)
        .placeholder(when: text.isEmpty, with: placeholder)
        .padding(.vertical, 12)
        .padding(.trailing, 30)
        .overlay(alignment: .trailing) { eyeButton }
        .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 16))
        .padding(.horizontal, 12)
        .frame(height: 44)
        .setBorder(
            width: 1,
            color: isFocused ? DagestanKitAsset.accentDefault.swiftUIColor : DagestanKitAsset.borderMuted.swiftUIColor
        )
    }
    
    private var eyeButton: some View {
        Button {
            showPassword.toggle()
        } label: {
            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                .foregroundStyle(DagestanKitAsset.iconSoft.swiftUIColor)
        }
        .opacity(isSecure ? 1 : 0)
    }
}

#Preview {
    PasswordTextFieldView(text: .constant(""), placeholder: "Some")
}
