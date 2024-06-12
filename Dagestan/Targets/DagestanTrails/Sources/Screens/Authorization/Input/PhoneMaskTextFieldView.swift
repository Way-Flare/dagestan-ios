import SwiftUI
import DesignSystem

struct PhoneMaskTextFieldView: View {
    @State private var isEditing = false
    @Binding var text: String

    let placeholder: String

    var body: some View {
        NumberPhoneMaskView(
            text: $text,
            isEditing: $isEditing,
            placeholder: placeholder
        )
        .frame(height: Grid.pt44)
        .padding(.leading, Grid.pt12)
        .setBorder(
            width: Grid.pt1,
            color: isEditing ? WFColor.accentPrimary : WFColor.borderMuted
        )
    }
}
