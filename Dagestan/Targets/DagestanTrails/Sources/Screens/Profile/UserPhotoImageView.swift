//
//  UserPhotoImageView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 05.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

struct UserPhotoImageView: View {
    let url: URL?
    
    var body: some View {
        if let url {
            LazyImage(url: url) { state in
                if state.isLoading {
                    ShimmerCircleView()
                } else if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Grid.pt96, height: Grid.pt96)
                        .overlay(
                            Circle()
                                .strokeBorder(WFColor.surfaceSecondary, lineWidth: Grid.pt2)
                        )
                        .clipShape(Circle())
                        .shadow(radius: Grid.pt10)
                }
            }
        } else {
            Circle()
                .fill(WFColor.surfacePrimary)
                .frame(width: Grid.pt96, height: Grid.pt96)
                .overlay(person)
                .overlay(
                    Circle()
                        .strokeBorder(WFColor.surfaceSecondary, lineWidth: Grid.pt2)
                )
        }
    }

    var person: some View {
        Image(systemName: "person")
            .resizable()
            .frame(width: Grid.pt28, height: Grid.pt28)
            .foregroundStyle(WFColor.iconSoft)
    }
}
