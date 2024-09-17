//
//  UIApplication+tapGesture().swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 01.06.2024.
//

import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct EndEditingOnTapModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

extension View {
    func endEditingOnTap() -> some View {
        modifier(EndEditingOnTapModifier())
    }
}
