//
//  ProfileContainerView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 21.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import CoreKit

struct ProfileContainerView: View {
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    let authService: AuthService
    private let keychainService = KeychainService()

    var body: some View {
        VStack {
            if isAuthorized {
                Text("Authed")
                Button("Logout") {
                    isAuthorized = false
                }
            } else {
                AuthorizationView(service: authService, keychain: keychainService)
            }
        }
    }
}
