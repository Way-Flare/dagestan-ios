//
//  SwiftUIView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct RestaurantView: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 10) {
                DagestanTrailsAsset.essentialForkDefault.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(DagestanKitAsset.onAccent.swiftUIColor)
                    .padding(8)
                    .background(DagestanKitAsset.accentSoft.swiftUIColor)
                    .cornerStyle(.constant(8))

                VStack(alignment: .leading) {
                    Text("Скалка-худяка fjsdofjsdiofsdf")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 100)
                        .lineLimit(1)
                    Text("Закрыто до 09:00")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(6)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)

            Triangle()
                .fill(Color.white)
                .frame(width: 20, height: 10)
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                .alignmentGuide(.bottom) { d in d[.bottom] - 5 }
        }
    }
}

#Preview {
    RestaurantView()
}
