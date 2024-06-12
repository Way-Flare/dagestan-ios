import SwiftUI

struct NumberPhoneMaskView: View {
    @Binding var text: String
    @Binding var isEditing: Bool

    let placeholder: String

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
        .padding(.vertical)
    }
}
