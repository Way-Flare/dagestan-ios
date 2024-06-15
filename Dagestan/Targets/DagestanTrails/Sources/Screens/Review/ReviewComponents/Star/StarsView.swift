//
//  StarsView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct StarsView: View {
    let amount: Int
    let size: Size
    let type: Style
    
    init(
        amount: Int,
        size: Size = .m,
        type: Style = .reviews
    ) {
        self.amount = amount
        self.size = size
        self.type = type
    }
    
    var body: some View {
        HStack(spacing: size.spacing) {
            ForEach(0..<type.rawValue, id: \.self) { index in
                DagestanTrailsAsset.star.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.value, height: size.value)
                    .foregroundStyle(index < amount ? WFColor.starActive : WFColor.surfaceFivefold)
            }
        }
    }
}

#Preview {
    StarsView(amount: 3, size: .l)
}
