import DesignSystem
import SwiftUI

struct PhoneMaskTextFieldView: View {
    @State private var isEditing = false
    @Binding var text: String

    let placeholder: String
    var isError = false

    var body: some View {
        NumberPhoneMaskView(
            text: $text,
            isEditing: $isEditing,
            placeholder: placeholder
        )
        .frame(height: Grid.pt44)
        .padding(.leading, Grid.pt12)
        .background(isError ? WFColor.errorContainerPrimary : WFColor.surfacePrimary)
        .cornerStyle(.constant(Grid.pt8))
        .setBorder(
            width: Grid.pt1,
            color: isError ? WFColor.errorPrimary : isEditing ? WFColor.accentPrimary : WFColor.borderMuted
        )
    }
}

#Preview {
    PhoneMaskTextFieldView(text: .constant("79818363211"), placeholder: "kosefm")
}
