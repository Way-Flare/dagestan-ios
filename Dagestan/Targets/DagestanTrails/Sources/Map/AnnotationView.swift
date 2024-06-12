//
//  AnnotationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.05.2024.
//

import SwiftUI
import DesignSystem

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

struct AnnotationView: View {
    let name: String
    let workingTime: String?
    let tagPlace: TagPlace?

    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 10) {
                (tagPlace?.icon ?? Image(systemName: "eye"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(WFColor.accentInverted)
                    .padding(8)
                    .background(WFColor.accentSoft)
                    .cornerStyle(.constant(8))

                VStack(alignment: .leading) {
                    Text(name)
                        .font(.manropeSemibold(size: Grid.pt14))
                        .foregroundColor(WFColor.foregroundPrimary)

                    if let workingTime {
                        Text(workingTime)
                            .font(.manropeRegular(size: Grid.pt12))
                            .foregroundColor(WFColor.foregroundSoft)
                    }
                }
                .lineLimit(1)
            }
            .padding(Grid.pt6)
            .background(Color.white)
            .cornerRadius(Grid.pt10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)

            Triangle()
                .fill(Color.white)
                .frame(width: 20, height: 10)
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                .alignmentGuide(.bottom) { d in d[.bottom] - 5 }
        }
        .frame(minWidth: Grid.pt140, maxWidth: Grid.pt260)
    }
}

#Preview {
    AnnotationView(name: "Хинкальная", workingTime: "Закрыто до 9:00", tagPlace: .nature)
}
