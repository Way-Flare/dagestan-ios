//
//  MyReviewsView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import DesignSystem
import SwiftUI

class MyReviewsViewModel: ObservableObject {
    @Published var feedbacks: LoadingState<[UserFeedback]> = .idle

    let feedbackService: IFeedbackService

    init(feedbackService: IFeedbackService) {
        self.feedbackService = feedbackService
    }

    @MainActor
    func loadAllFeedbacks() {
        feedbacks = .loading

        Task {
            do {
                let loadedFeedbacks = try await feedbackService.getAllFeedback()
                feedbacks = .loaded(loadedFeedbacks)
            } catch {
                feedbacks = .failed(error.localizedDescription)
                print("Failed to load place: \(error.localizedDescription)")
            }
        }
    }
}

struct MyReviewsView: View {
    @EnvironmentObject var viewModel: MyReviewsViewModel
    let profile: Profile?
    var body: some View {
        getContentView()
            .background(WFColor.surfaceSecondary)
            .onViewDidLoad {
                viewModel.loadAllFeedbacks()
            }
            .setCustomBackButton()
            .setCustomNavigationBarTitle(title: "Мои отзывы")
    }

    @ViewBuilder
    func getContentView() -> some View {
        if viewModel.feedbacks.isLoading {
            ShimmerMyFeedbacksView()
        } else {
            ScrollView {
                if let feedbacks = viewModel.feedbacks.data {
                    LazyVStack(alignment: .leading) {
                        ForEach(feedbacks, id: \.id) { feedback in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(feedback.content.title)
                                    .font(.manropeExtrabold(size: 18))
                                    .foregroundStyle(WFColor.foregroundPrimary)

                                VStack(alignment: .leading, spacing: 8) {
                                    UserInfoFeedbackView(
                                        id: profile?.id,
                                        avatar: profile?.avatar,
                                        username: profile?.username ?? "username",
                                        createdAt: feedback.createdAt,
                                        stars: feedback.stars
                                    )
                                    if !feedback.comment.isEmpty {
                                        ExpandableTextView(text: feedback.comment) { isExpanded in
                                            Text(isExpanded ? "Свернуть" : "Раскрыть")
                                                .underline(pattern: .dot)
                                                .foregroundStyle(WFColor.iconAccent)
                                        }
                                    }
                                    if let images = feedback.images,
                                       !images.isEmpty {
                                        ImageCarousel(images: images)
                                            .frame(height: Grid.pt96)
                                    }
                                }
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(WFColor.surfacePrimary)
                            .cornerStyle(.constant(12))
                        }
                        .padding([.horizontal, .top], 12)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

// #Preview {
//    MyReviewsView(
//        profile: .init(
//            id: 2312,
//            avatar: nil,
//            username: "dasad",
//            phone: "+79818363211",
//            email: "email"
//        )
//    )
// }
