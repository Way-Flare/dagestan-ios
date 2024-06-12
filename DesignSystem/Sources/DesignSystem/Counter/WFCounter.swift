//
//  WFCounter.swift
//
//  Created by Рассказов Глеб on 10.06.2024.

import SwiftUI

public struct WFCounter: View {
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
            .font(.manropeSemibold(size: size.fontSize))
            .foregroundStyle(style.foregroundColor)
            .frame(width: size.value, height: size.value)
            .background(style.backgroundColor)
            .cornerStyle(.round)
    }
}

#Preview {
    WFCounter(style: .accent, size: .l, number: 3)
}
