//
//  AuthorizationViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

class AuthorizationViewModel: ObservableObject {
    private let authService: AuthService
    @Published var path = NavigationPath()

    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var lastDigits = "" {
        didSet {
            withAnimation(.interactiveSpring) {
                isFailedValidation = lastDigits != "1234" && lastDigits.count == 4
            }
        }
    }

    @Published var isFailedValidation = false
    
    init(authService: AuthService = AuthService(networkService: DTNetworkService())) {
        self.authService = authService
    }
    
    func login() async {
        do {
            let _ = try await authService.login(phone: phoneNumber, password: password)
        } catch {
            print(error)
        }
    }
}
