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
    @StateObject var viewModel: ProfileViewModel
    @StateObject var feedbackViewModel: MyReviewsViewModel
    let authService: AuthService
    
    init(authService: AuthService, feedbackService: IFeedbackService) {
        self.authService = authService
        self._feedbackViewModel = StateObject(wrappedValue: MyReviewsViewModel(feedbackService: feedbackService))
        self._viewModel = StateObject(wrappedValue: ProfileViewModel())
    }

    var body: some View {
        VStack {
            if isAuthorized {
                ProfileView(viewModel: viewModel, feedbackViewModel: feedbackViewModel)
            } else {
                AuthorizationView(service: authService)
            }
        }
    }
}
