//
//  SwiftUIView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
import SwiftUI

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
    let name: String
    let workingTime: String?

    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 10) {
                DagestanKitAsset.essentialForkDefault.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(DagestanKitAsset.onAccent.swiftUIColor)
                    .padding(8)
                    .background(DagestanKitAsset.accentSoft.swiftUIColor)
                    .cornerStyle(.constant(8))

                VStack(alignment: .leading) {
                    Text(name)
                        .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: 14))
                        .foregroundColor(DagestanKitAsset.fgDefault.swiftUIColor)

                    if let workingTime {
                        Text(workingTime)
                            .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 12))
                            .foregroundColor(DagestanKitAsset.fgSoft.swiftUIColor)
                    }
                }
                .lineLimit(1)
            }
            .padding(6)
            .frame(width: 150)
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
    RestaurantView(name: "Скалка хуялка", workingTime: "Закрыто до 9:00")
}
