//
//  ShimmerProfileView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 30.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ShimmerCircleView: View {
    var body: some View {
        Circle()
            .fill()
            .frame(width: 96, height: 96)
            .skeleton()
            .cornerStyle(.round)
    }
}

#Preview {
    ShimmerCircleView()
}
