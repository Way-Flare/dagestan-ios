//
//  PasswordViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

class PasswordViewModel: ObservableObject {
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var validationRules: [ValidationRule] = []
    @Published var showAlert = false
    var isFirstInput = true
    
    var isButtonDisabled: Bool {
        validationRules.contains(where: { !$0.isValid })
    }
    
    private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    // swiftlint:disable opening_brace
    // swiftlint:disable large_tuple
    private let rulesDescriptions: [(description: String, validator: (String) -> Bool, icon: Image)] = [
        (
            "Длина пароля не менее 6 символов",
            { $0.count >= 6 },
            DagestanKitAsset.checkmark.swiftUIImage
        ),
        (
            "Используй хотя бы 1 заглавную букву (A-Z)",
            { $0.rangeOfCharacter(from: .uppercaseLetters) != nil },
            DagestanKitAsset.checkmark.swiftUIImage
        ),
        (
            "Используй цифры (0-9)",
            { $0.rangeOfCharacter(from: .decimalDigits) != nil },
            DagestanKitAsset.checkmark.swiftUIImage
        ),
        (
            "Не используйте пробелов",
            { $0.rangeOfCharacter(from: .whitespaces) == nil },
            DagestanKitAsset.essentialCloseLinier.swiftUIImage
        ),
        (
            "Используй только латинские символы",
            { 
                $0.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")) != nil &&
                $0.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").inverted) == nil
            },
            DagestanKitAsset.checkmark.swiftUIImage
        )
    ]
    // swiftlint:enable large_tuple
    // swiftlint:enable opening_brace

    init() {
        $password
            .receive(on: RunLoop.main)
            .map { [weak self] password -> [ValidationRule] in
                guard let self else {
                    return self?.createInitialRules() ?? []
                }
                if isFirstInput && !password.isEmpty {
                     isFirstInput = false
                     return validate(password: password)
                 } else if !isFirstInput {
                     return validate(password: password)
                 }
                 return createInitialRules()
            }
            .assign(to: &$validationRules)
    }
    
    private func createInitialRules() -> [ValidationRule] {
        rulesDescriptions.map {
            ValidationRule(
                description: $0.description,
                isValid: false,
                correctIcon: $0.icon,
                showIcon: false
            )
        }
    }

    private func validate(password: String) -> [ValidationRule] {
        rulesDescriptions.map {
            ValidationRule(
                description: $0.description,
                isValid: $0.validator(password),
                correctIcon: $0.icon
            )
        }
    }
}
