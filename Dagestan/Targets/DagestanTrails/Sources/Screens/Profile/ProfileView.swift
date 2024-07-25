//
//  ProfileView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        StickyHeaderView()
            .edgesIgnoringSafeArea(.top)
    }
}

struct StickyHeaderView: View {
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .global).minY
                let scale = max(1, 1 + minY / 500)
                
                DagestanTrailsAsset.profileBg.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .clipped()
                    .scaleEffect(scale, anchor: .top)
                    .offset(y: minY > 0 ? minY / scale : 0)
            }
            .frame(height: 200)
            .edgesIgnoringSafeArea(.top) // Игнорируем верхнюю safe area

            VStack(alignment: .leading) {
                ForEach(0..<100) { i in
                    Text("Item \(i)")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
