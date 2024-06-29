//
//  RegisterViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import SwiftUI
import CoreKit

@MainActor
class RegisterViewModel: ObservableObject {
    private let authService: AuthService

    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var code = ""

    @Published var isFailedValidation = false

    init(authService: AuthService = AuthService(networkService: DTNetworkService())) { // Временно
        self.authService = authService
    }

    func register() async {
        do {
            let _ = try await authService.registerSendVerification(phone: phoneNumber)
        } catch {
            print(error)
        }
    }
    
    func checkVerification() async {
        guard let code = Int(code) else { return }
        do {
            let _ = try await authService.registerConfirmVerification(phone: phoneNumber, code: code)
            isFailedValidation = false
        } catch {
            print(error)
            isFailedValidation = true
        }
    }
}
