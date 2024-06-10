//
//  DKCounter.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct DKCounter: View {
    let style: Style
    let size: Size
    let number: Int
    
    public init(style: Style, size: Size, number: Int) {
        self.style = style
        self.size = size
        self.number = number
    }
    
    public var body: some View {
        Text(String(number))
            .font(DagestanKitFontFamily.Manrope.semiBold.swiftUIFont(size: size.fontSize))
            .foregroundStyle(style.foregroundColor)
            .frame(width: size.value, height: size.value)
            .background(style.backgroundColor)
            .cornerStyle(.round)
    }
}

#Preview {
    DKCounter(style: .accent, size: .l, number: 3)
}
