//
//  PasswordViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import SwiftUI
import CoreKit

protocol IPasswordViewModel: ObservableObject {
    var password: String { get set }
    var confirmPassword: String { get set }
    var validationRules: [ValidationRule] { get set }
    var showAlert: Bool { get set }
    var isButtonDisabled: Bool { get }
    
    func registerPhone() async
}

class PasswordViewModel: IPasswordViewModel {
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var validationRules: [ValidationRule] = []
    @Published var showAlert = false

    var isButtonDisabled: Bool {
        validationRules.contains(where: { !$0.isValid })
    }
    
    private let phone: String
    private let authService: AuthService
    private var isFirstInput = true
    private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    // swiftlint:disable opening_brace
    // swiftlint:disable large_tuple
    private let rulesDescriptions: [(description: String, validator: (String) -> Bool, icon: Image)] = [
        (
            "Длина пароля не менее 6 символов",
            { $0.count >= 6 },
            Image(systemName: "checkmark")
        ),
        (
            "Используй хотя бы 1 заглавную букву (A-Z)",
            { $0.rangeOfCharacter(from: .uppercaseLetters) != nil },
            Image(systemName: "checkmark")
        ),
        (
            "Используй цифры (0-9)",
            { $0.rangeOfCharacter(from: .decimalDigits) != nil },
            Image(systemName: "checkmark")
        ),
        (
            "Не используйте пробелов",
            { $0.rangeOfCharacter(from: .whitespaces) == nil },
            Image(systemName: "xmark")
        ),
        (
            "Используй только латинские символы",
            {
                $0.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")) != nil &&
                $0.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").inverted) == nil
            },
            Image(systemName: "checkmark")
        )
    ]
    // swiftlint:enable large_tuple
    // swiftlint:enable opening_brace

    init(authService: AuthService, phone: String) {
        self.authService = authService
        self.phone = phone
        setupBindings()
    }
    
    func registerPhone() async {
        do {
            let token = try await authService.register(phone: phone, password: password, repeated: confirmPassword)
            KeychainService.handleToken(access: token.access, refresh: token.refresh)
        } catch {
            print(error)
        }
    }

    private func setupBindings() {
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
