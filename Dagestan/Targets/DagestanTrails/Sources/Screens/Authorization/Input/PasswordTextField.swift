import SwiftUI
import DesignSystem

struct PasswordTextFieldView: View {
    @State private var showPassword = false
    @Binding var text: String
    @FocusState var isFocused: Bool

    var placeholder: String
    var isError: Bool
    var isSecure = true
    
    init(text: Binding<String>, placeholder: String, isError: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.isError = isError
    }

    var body: some View {
        ZStack {
            SecureField(placeholder, text: $text)
                .textContentType(.oneTimeCode)
                .opacity(isSecure && !showPassword ? Grid.pt1 : 0.0001)

            TextField(placeholder, text: $text)
                .opacity(isSecure && !showPassword ? 0.0001 : 1)
        }
        .focused($isFocused)
        .placeholder(when: text.isEmpty, with: placeholder)
        .padding(.vertical, Grid.pt12)
        .padding(.trailing, Grid.pt30)
        .overlay(alignment: .trailing) { eyeButton }
        .font(.manropeRegular(size: Grid.pt16))
        .padding(.horizontal, Grid.pt12)
        .frame(height: Grid.pt44)
        .background(isError ? WFColor.errorContainerPrimary : WFColor.surfacePrimary)
        .setBorder(
            width: Grid.pt1,
            color: isError ? WFColor.errorPrimary : isFocused ? WFColor.accentPrimary : WFColor.borderMuted
        )
    }

    private var eyeButton: some View {
        Button {
            showPassword.toggle()
        } label: {
            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                .frame(width: Grid.pt20, height: Grid.pt20)
                .foregroundStyle(WFColor.iconSoft)
        }
        .opacity(isSecure ? Grid.pt1 : Grid.pt0)
    }
}

#Preview {
    PasswordTextFieldView(text: .constant(""), placeholder: "Some", isError: true)
}
