//
//  PlaceReviewAndRatingView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct PlaceReviewAndRatingView: View {
    let review: ReviewModel
    let feedback: PlaceFeedback?
    @AppStorage("isAuthorized") var isAuthorized = false
    @State private var showingReview = false
    @State private var showAlert = false
    @State private var rating = 0
    var isPlaces: Bool
    var onSuccessSaveButton: (() -> Void)?
    
    var hasFeedbackFromUser: Bool {
        return feedback?.user.username == UserDefaults.standard.string(forKey: "username")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Grid.pt12) {
            Text("Отзывы и оценки")
                .font(.manropeSemibold(size: Grid.pt18))
                .foregroundStyle(WFColor.foregroundPrimary)

            VStack(alignment: hasFeedbackFromUser ? .leading : .center, spacing: Grid.pt12) {
                RatingWingView(rating: review.rating, reviewsCount: review.feedbackCount)
                Divider()
                    .background(WFColor.borderMuted)
                    .frame(height: Grid.pt16)

                if let feedback, hasFeedbackFromUser {
                    VStack(alignment: .leading, spacing: Grid.pt12) {
                        Text("Ваш отзыв")
                            .font(.manropeSemibold(size: Grid.pt16))
                        UserReviewView(feedback: feedback)
                    }
                } else {
                    markThisPlaceView
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Grid.pt12)
            .padding(.top, Grid.pt16)
            .padding(.bottom, Grid.pt20)
            .background(WFColor.surfacePrimary)
            .cornerStyle(.constant(Grid.pt12))
            .alert("Вы не авторизованы", isPresented: $showAlert) {
                Button("Понял принял обработал", role: .cancel) {}
            } message: {
                Text("Перейди, по-братски, на вкладку ‘Профиль’ и авторизуйся")
            }
        }
        .sheet(isPresented: $showingReview) {
            ReviewView(
                initialRating: $rating,
                review: review,
                onSaveButton: onSuccessSaveButton,
                isPlaces: isPlaces
            )
        }
    }

    private var markThisPlaceView: some View {
        VStack(spacing: Grid.pt12) {
            Text("Оцените место и оставьте отзыв")
                .foregroundStyle(WFColor.iconPrimary)

            StarsView(amount: rating, size: .l) { new in
                guard isAuthorized else {
                    showAlert = true
                    return
                }
                self.showingReview = true
                rating = new
            }
        }
    }
}
