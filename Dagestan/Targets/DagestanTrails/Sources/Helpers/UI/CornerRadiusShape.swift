//
//  CornerRadiusShape.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.05.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import SwiftUI

struct CornerRadiusShape: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner

    init(
        radius: CGFloat,
        corners: UIRectCorner
    ) {
        self.radius = radius
        self.corners = corners
    }

    init(cornerStyle: CornerStyle) {
        self.radius = cornerStyle.cornerRadius
        self.corners = cornerStyle.corners
    }

    func path(in rect: CGRect) -> Path {
        if corners == .allCorners {
            return Path(
                roundedRect: rect,
                cornerRadius: radius
            )
        } else {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
}

// MARK: - View extension

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            CornerRadiusShape(
                radius: radius,
                corners: corners
            )
        )
    }

    @ViewBuilder
    func cornerStyle(_ cornerStyle: CornerStyle) -> some View {
        clipShape(CornerRadiusShape(cornerStyle: cornerStyle))
    }
}

private extension CornerStyle {
    var cornerRadius: CGFloat {
            switch self {
            case .round:
                return .greatestFiniteMagnitude
            case .constant(let cornerRadius, _):
                return cornerRadius
        }
    }

    var corners: UIRectCorner {
            switch self {
            case .round:
                return .allCorners
            case .constant(_, let cornerMask):
                return UIRectCorner(cornerMask)
        }
    }
}

private extension UIRectCorner {
    init(_ caCorners: CACornerMask) {
        let corners = Self.from(caCorners)
        self.init([corners])
    }

    static func from(_ corners: CACornerMask) -> UIRectCorner {
        if corners.contains(.all) {
            return .allCorners
        }

        var rectCorners = UIRectCorner()
        if corners.contains(.layerMinXMinYCorner) {
            rectCorners.insert(.topLeft)
        }

        if corners.contains(.layerMaxXMinYCorner) {
            rectCorners.insert(.topRight)
        }

        if corners.contains(.layerMinXMaxYCorner) {
            rectCorners.insert(.bottomLeft)
        }

        if corners.contains(.layerMaxXMaxYCorner) {
            rectCorners.insert(.bottomRight)
        }
        return rectCorners
    }
}
