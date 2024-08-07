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
    @AppStorage("isAuthorized") var isAuthorized = false
    let authService: AuthService
    let feedbackService: IFeedbackService
    
    init(authService: AuthService, feedbackService: IFeedbackService) {
        self.authService = authService
        self.feedbackService = feedbackService
    }

    var body: some View {
        VStack {
            if isAuthorized {
                ProfileView(feedbackService: feedbackService)
            } else {
                AuthorizationView(service: authService)
            }
        }
    }
}
