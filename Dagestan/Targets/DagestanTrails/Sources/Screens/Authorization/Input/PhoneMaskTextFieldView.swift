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
        .frame(height: 44)
        .padding(.leading, 12)
        .setBorder(
            width: 1,
            color: isEditing ? WFColor.accentPrimary: WFColor.borderMuted
        )
    }
}
