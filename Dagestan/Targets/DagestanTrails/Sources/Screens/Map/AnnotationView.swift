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
            HStack(spacing: Grid.pt10) {
                (tagPlace?.icon ?? Image(systemName: "eye"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: Grid.pt24, height: Grid.pt24)
                    .foregroundColor(WFColor.accentInverted)
                    .padding(Grid.pt8)
                    .background(WFColor.accentSoft)
                    .cornerStyle(.constant(Grid.pt8))

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
            .background(WFColor.surfacePrimary)
            .cornerRadius(Grid.pt10)
            .shadow(color: .gray, radius: Grid.pt2, x: Grid.pt0, y: Grid.pt2)

            Triangle()
                .fill(WFColor.surfacePrimary)
                .frame(width: Grid.pt20, height: Grid.pt10)
                .shadow(color: .gray, radius: Grid.pt2, x: Grid.pt0, y: Grid.pt2)
                .alignmentGuide(.bottom) { d in d[.bottom] - 5 }
        }
        .frame(minWidth: Grid.pt140, maxWidth: Grid.pt260)
    }
}

#Preview {
    AnnotationView(name: "Хинкальная", workingTime: "Закрыто до 9:00", tagPlace: .nature)
}
