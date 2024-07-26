//
//  ProfileView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct ProfileView: View {
    @State var offset: CGFloat = .zero

    var body: some View {
        ScrollViewWithScrollOffset(scrollOffset: $offset) {
            VStack(spacing: .zero) {
                ProfileImageView(offset: $offset)
                menuSection
                    .overlay(
                        profileCircle,
                        alignment: .top
                    )
                    .offset(y: -24)
            }
        }
        .coordinateSpace(name: "pullToResize")
        .ignoresSafeArea()
        .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)

    }
    
    private var profileCircle: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(WFColor.surfacePrimary)
                .frame(width: 96, height: 96)
                .overlay(
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(WFColor.iconSoft)
                )
                .overlay(
                    Circle()
                        .strokeBorder(WFColor.surfaceSecondary, lineWidth: 2)
                )
            
            Text("[username]")
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: 18))
        }
        .offset(y: -65)
    }

    private var menuSection: some View {
        VStack(spacing: 10) {
            MenuItemView(icon: DagestanTrailsAsset.starOutline.swiftUIImage, title: "Мои отзывы")
            MenuItemView(icon: DagestanTrailsAsset.profileCircle.swiftUIImage, title: "Управление аккаунтом")
            MenuItemView(icon: DagestanTrailsAsset.logout.swiftUIImage, title: "Выйти")
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 79)
        .padding(.horizontal, 12)
        .background(WFColor.surfaceSecondary)
        .cornerRadius(12)
    }
}

struct ProfileImageView: View {
    @Binding var offset: CGFloat

    var body: some View {
        GeometryReader { proxy in
            DagestanTrailsAsset.profileBg.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.horizontal, min(0, -offset))
                .frame(width: proxy.size.width,
                       height: proxy.size.height + max(0, offset))
                .offset(CGSize(width: 0, height: min(0, -offset)))
        }
        .aspectRatio(CGSize(width: 375, height: 280), contentMode: .fit)
    }
}

struct MenuItemView: View {
    var icon: Image
    var title: String

    var body: some View {
        HStack(spacing: 10) {
            icon
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.green)
            Text(title)
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeRegular(size: 16))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WFColor.surfacePrimary)
        .cornerRadius(10)
    }
}

#Preview {
    ProfileView()
}
