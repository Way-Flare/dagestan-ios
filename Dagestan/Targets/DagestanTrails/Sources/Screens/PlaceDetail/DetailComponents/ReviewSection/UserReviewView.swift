//
//  UserReviewView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 17.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct UserReviewView: View {
    let feedback: PlaceFeedback
    
    var body: some View {
        VStack(alignment: .leading, spacing: Grid.pt8) {
            HStack(spacing: Grid.pt8) {
                WFAvatarView.initials(feedback.user.username, userId: String(feedback.id), size: .size44)
                VStack(alignment: .leading, spacing: Grid.pt4) {
                    Text(feedback.user.username)
                        .font(.manropeRegular(size: Grid.pt16))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    
                    HStack(spacing: Grid.pt8) {
                        StarsView(amount: feedback.stars, size: .s)
                        Text(feedback.createdAt)
                            .font(.manropeRegular(size: Grid.pt14))
                            .foregroundStyle(WFColor.foregroundSoft)
                    }
                }
            }
            VStack(alignment: .leading, spacing: Grid.pt12) {
                if let comment = feedback.comment {
                    ExpandableTextView(text: comment) { isExpanded in
                        Text(isExpanded ? "Свернуть" : "Раскрыть")
                            .underline(pattern: .dot)
                            .foregroundStyle(WFColor.iconAccent)
                    }
                }
                
                ImageCarousel(images: feedback.images)
                    .frame(height: Grid.pt96)
            }
        }   
    }
}

#Preview {
    UserReviewView(feedback: .mock())
}
