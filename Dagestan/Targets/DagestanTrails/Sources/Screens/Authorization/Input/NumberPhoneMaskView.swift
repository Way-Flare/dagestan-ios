import SwiftUI
import DesignSystem

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
        .overlay(eraseButton)
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
            }
            .buttonStyle(.plain)
            .padding(.trailing, Grid.pt12)
        }
    }
}
