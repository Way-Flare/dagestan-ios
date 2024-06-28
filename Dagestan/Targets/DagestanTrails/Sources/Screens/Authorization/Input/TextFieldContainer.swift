//
//  TextFieldContainer.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import UIKit
import SwiftUI
import DesignSystem

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

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.font = .manropeRegular(size: Grid.pt16)
        textField.textColor = UIColor(WFColor.foregroundPrimary)
        textField.text = text.wrappedValue
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(WFColor.foregroundSoft),
            .font: UIFont.manropeRegular(size: Grid.pt16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)

        context.coordinator.setup(textField)

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.text.wrappedValue
    }
}

extension TextFieldContainer {
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
