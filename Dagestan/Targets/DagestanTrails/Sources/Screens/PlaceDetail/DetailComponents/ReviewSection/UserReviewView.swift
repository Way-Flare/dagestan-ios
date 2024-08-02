//
//  UserReviewView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 17.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

struct UserReviewView: View {
    let feedback: PlaceFeedback

    var body: some View {
        VStack(alignment: .leading, spacing: Grid.pt8) {
            UserInfoFeedbackView(
                id: feedback.id,
                avatar: feedback.user.avatarURL,
                username: feedback.user.username,
                createdAt: feedback.createdAt,
                stars: feedback.stars
            )
            VStack(alignment: .leading, spacing: Grid.pt12) {
                if let comment = feedback.comment,
                   !comment.isEmpty {
                    ExpandableTextView(text: comment) { isExpanded in
                        Text(isExpanded ? "Свернуть" : "Раскрыть")
                            .underline(pattern: .dot)
                            .foregroundStyle(WFColor.iconAccent)
                    }
                }
                if !feedback.images.isEmpty {
                    ImageCarousel(images: feedback.images)
                        .frame(height: Grid.pt96)
                }
            }
        }
    }
}


struct UserInfoFeedbackView: View {
    let id: Int
    let avatar: URL?
    let username: String
    let createdAt: String
    let stars: Int
    
    var body: some View {
        HStack(spacing: Grid.pt8) {
            LazyImage(url: avatar) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .frame(width: 44, height: 44)
                        .aspectRatio(contentMode: .fit)
                        .cornerStyle(.round)
                } else {
                    WFAvatarView.initials(username, userId: String(id), size: .size44)
                }
            }
            VStack(alignment: .leading, spacing: Grid.pt4) {
                Text(username)
                    .font(.manropeRegular(size: Grid.pt16))
                    .foregroundStyle(WFColor.foregroundPrimary)

                HStack(spacing: Grid.pt8) {
                    StarsView(amount: stars, size: .s)
                    Text(createdAt)
                        .font(.manropeRegular(size: Grid.pt14))
                        .foregroundStyle(WFColor.foregroundSoft)
                }
            }
        }
    }
}
