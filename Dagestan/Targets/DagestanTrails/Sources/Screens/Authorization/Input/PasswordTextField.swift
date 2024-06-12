import SwiftUI
import DesignSystem

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
                .opacity(isSecure && !showPassword ? Grid.pt1 : Grid.pt0)

            TextField(placeholder, text: $text)
                .opacity(isSecure && !showPassword ? Grid.pt0 : Grid.pt1)
        }
        .focused($isFocused)
        .placeholder(when: text.isEmpty, with: placeholder)
        .padding(.vertical, Grid.pt12)
        .padding(.trailing, Grid.pt30)
        .overlay(alignment: .trailing) { eyeButton }
        .font(.manropeRegular(size: Grid.pt16))
        .padding(.horizontal, Grid.pt12)
        .frame(height: Grid.pt44)
        .setBorder(
            width: Grid.pt1,
            color: isFocused ? WFColor.accentPrimary : WFColor.borderMuted
        )
    }

    private var eyeButton: some View {
        Button {
            showPassword.toggle()
        } label: {
            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                .foregroundStyle(WFColor.iconSoft)
        }
        .opacity(isSecure ? Grid.pt1 : Grid.pt0)
    }
}

#Preview {
    PasswordTextFieldView(text: .constant(""), placeholder: "Some")
}
