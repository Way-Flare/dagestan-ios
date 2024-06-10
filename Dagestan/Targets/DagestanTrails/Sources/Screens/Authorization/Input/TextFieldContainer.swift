//
//  TextFieldContainer.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct TextFieldContainer: UIViewRepresentable {
    @Binding var isEditing: Bool
    private var placeholder: String
    private var text: Binding<String>

    init(
        _ placeholder: String,
        text: Binding<String>,
        isEditing: Binding<Bool>
    ) {
        self.placeholder = placeholder
        self.text = text
        self._isEditing = isEditing
    }

    func makeCoordinator() -> TextFieldContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innertTextField = UITextField(frame: .zero)
        innertTextField.placeholder = placeholder
        innertTextField.font = DagestanKitFontFamily.Manrope.regular.font(size: 16)
        innertTextField.textColor = DagestanKitAsset.fgDefault.color
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        innertTextField.keyboardType = .numberPad

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: DagestanKitAsset.fgSoft.color,
        ]
        innertTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)

        context.coordinator.setup(innertTextField)

        return innertTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldContainer

        init(_ textFieldContainer: TextFieldContainer) {
            self.parent = textFieldContainer
        }

        func setup(_ textField: UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
            textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        }

        @objc
        func textFieldDidChange(_ textField: UITextField) {
            parent.text.wrappedValue = textField.text ?? ""
        }

        @objc
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isEditing = true
        }

        @objc
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isEditing = false
        }

        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.count <= 18
        }
    }
}
