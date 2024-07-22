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
    let authService: AuthService
    @ObservedObject var authViewModel: AuthorizationViewModel

    var body: some View {
        if authViewModel.isAuthorized { // вот как узнать что авторизован
            VStack {
                Text("Authed")
                Button("Logout") {
                    authViewModel.isAuthorized = false
                }
            }
        } else {
            AuthorizationView(service: authService, authViewModel: authViewModel)
        }
    }
}
