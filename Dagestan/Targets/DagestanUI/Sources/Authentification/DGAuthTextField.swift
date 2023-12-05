import SwiftUI

public struct DGAuthTextField: View {
    @FocusState private var fieldIsFocused: Bool

    var text: Binding<String>
    var placeholder: LocalizedStringKey
    var isSecure: Bool = false

    public var body: some View {
        inputField
            .padding()
            .focused($fieldIsFocused)
            .textInputAutocapitalization(.never)
            .textContentType(isSecure ? .password: .password)
            .keyboardType(isSecure ? .default: .emailAddress)
            .disableAutocorrection(true)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.tertiary)
                    .opacity(0.8)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(fieldIsFocused ? .cyan: .clear, lineWidth: 1)
            )
    }

    @ViewBuilder
    private var inputField: some View {
        if isSecure {
            SecureField(placeholder, text: text)
        } else {
            TextField(placeholder, text: text)
        }
    }

    public init(
        text: Binding<String>,
        placeholder: LocalizedStringKey,
        isSecure: Bool = false
    ) {
        self.text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
    }

}
