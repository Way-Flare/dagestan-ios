//
//  WFSpinner.swift
//
//
//  Created by Рассказов Глеб on 30.06.2024.
//

import SwiftUI

struct WFSpinner: View {
    @State private var isSpinning = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(WFColor.surfacePrimary, style: StrokeStyle(lineWidth: Grid.pt3, lineCap: .round))
            .rotationEffect(Angle(degrees: isSpinning ? Grid.pt360 : .zero))
            .animation(Animation.linear(duration: 0.75).repeatForever(autoreverses: false), value: isSpinning)
            .onAppear {
                isSpinning = true
            }
            .frame(width: Grid.pt24, height: Grid.pt24)
    }
}

#Preview {
    WFSpinner()
}
