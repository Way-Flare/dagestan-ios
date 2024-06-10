//
//  RegisterViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

class RegisterViewModel: ObservableObject {
    private let authService: AuthService

    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var code = "" {
        willSet {
            withAnimation(.interactiveSpring) {
                isFailedValidation = newValue != "3636" && newValue.count == 4
            }
        }
    }

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
}
