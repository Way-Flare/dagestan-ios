import DesignSystem
import SwiftUI

struct PhoneMaskTextFieldView: View {
    @State private var isEditing = false
    @Binding var text: String

    let placeholder: String

    var isError = false
    var textChangedBinding: Binding<String> {
        Binding<String>(
            get: {
                FilterNumberPhone.format(phone: text)
            },
            set: {
                text = FilterNumberPhone.extractNumbers(from: $0)
            }
        )
    }

    var body: some View {
        TextFieldContainer(
            placeholder,
            text: textChangedBinding,
            isEditing: $isEditing
        )
        .overlay(eraseButton)
        .frame(height: Grid.pt44)
        .padding(.leading, Grid.pt12)
        .background(isError ? WFColor.errorContainerPrimary : WFColor.surfacePrimary)
        .cornerStyle(.constant(Grid.pt8))
        .setBorder(
            width: Grid.pt1,
            color: isError ? WFColor.errorPrimary : isEditing ? WFColor.accentPrimary : WFColor.borderMuted
        )
    }
    
    private var eraseButton: some View {
        HStack {
            Spacer()
            Button {
                text = !text.isEmpty ? "" : text
            } label: {
                Image(systemName: !text.isEmpty ? "multiply.circle.fill" : "person.fill")
                    .frame(width: Grid.pt20, height: Grid.pt20)
                    .foregroundStyle(WFColor.iconSoft)
                    .frame(width: Grid.pt44, height: Grid.pt44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PhoneMaskTextFieldView(text: .constant("79818363211"), placeholder: "kosefm")
}
