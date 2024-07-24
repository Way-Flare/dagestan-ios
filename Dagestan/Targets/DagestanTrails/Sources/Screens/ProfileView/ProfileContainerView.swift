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
    @EnvironmentObject var authStatus: AuthStatus

    var body: some View {
        VStack {
            if authStatus.isAuthorized {
                Text("Authed")
                Button("Logout") {
                    authStatus.isAuthorized = false
                }
            } else {
                AuthorizationView(service: authService, authStatus: authStatus)
            }
        }
    }
}
