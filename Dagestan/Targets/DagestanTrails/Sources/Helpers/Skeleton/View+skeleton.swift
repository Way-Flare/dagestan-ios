//
//  View+skeleton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.05.2024.
//

import SwiftUI
import DesignSystem

extension View {
    func skeleton(
        show loading: Bool = true,
        cornerStyle: CornerStyle = .constant(16)
    ) -> some View {
        modifier(
            SkeletonModifier(isLoading: loading, cornerStyle: cornerStyle)
        )
    }
}
