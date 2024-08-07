//
//  ShimmerPromocodeView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct ShimmerPromocodeView: View {
    var body: some View {
        VStack(spacing: 12) {
            makeRectangle(width: 250, height: 64)
                .cornerStyle(.constant(12))
            makeRectangle(width: 130, height: 32)
                .cornerStyle(.constant(4))
        }
    }
    
    private func makeRectangle(height: CGFloat) -> some View {
        Rectangle()
            .fill()
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .skeleton()
    }

    private func makeRectangle(width: CGFloat, height: CGFloat) -> some View {
        Rectangle()
            .fill()
            .frame(width: width, height: height)
            .skeleton()
    }
}

#Preview {
    ShimmerPromocodeView()
}
