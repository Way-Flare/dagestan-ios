//
//  StarsView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct StarsView: View {
    let amount: Int
    let size: Size
    let type: Style
    let onSelectionChange: ((Int) -> Void)?

    init(
        amount: Int = 0,
        size: Size = .m,
        type: Style = .reviews,
        onSelectionChange: ((Int) -> Void)? = nil
    ) {
        self.amount = amount
        self.size = size
        self.type = type
        self.onSelectionChange = onSelectionChange
    }

    var body: some View {
        HStack(spacing: size.spacing) {
            ForEach(0 ..< type.rawValue, id: \.self) { index in
                DagestanTrailsAsset.star.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.value, height: size.value)
                    .foregroundStyle(
                        index < amount ? WFColor.starActive : WFColor.starPrimary
                    )
                    .onTapGesture {
                        onSelectionChange?(index + 1)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                updateRating(from: gesture.location)
                            }
                    )
                    .disabled(onSelectionChange == nil)
            }
        }
    }
    
    private func updateRating(from location: CGPoint) {
        let starWidth = size
        let newRating = Int(location.x / (size.value + starWidth.spacing)) + 1
        if newRating > 0 && newRating <= type.rawValue {
            onSelectionChange?(newRating)
        }
    }
}

#Preview {
    @State var amount = 0
    
    return StarsView(amount: amount, size: .l) { rating in
        amount = rating
        print(rating)
    }
}
