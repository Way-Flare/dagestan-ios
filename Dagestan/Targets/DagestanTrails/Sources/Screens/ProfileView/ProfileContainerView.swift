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
    @AppStorage("isAuthorized")
    var isAuthorized = false
    let authService: AuthService

    var body: some View {
        VStack {
            if isAuthorized {
                ProfileView()
            } else {
                AuthorizationView(service: authService)
            }
        }
    }
}
