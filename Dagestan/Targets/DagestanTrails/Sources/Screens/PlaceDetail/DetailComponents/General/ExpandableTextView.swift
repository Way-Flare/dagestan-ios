//
//  ExpandableTextView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 17.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ExpandableTextView<T: View>: View {
    @State private var expanded = false
    @State private var textExceedsLimit = false
    
    private let text: String
    private let lineLimit: Int
    private let labelButton: (Bool) -> T

    init(
        text: String,
        lineLimit: Int = 80,
        labelButton: @escaping ((Bool) -> T)
    ) {
        self.text = text
        self.lineLimit = lineLimit
        self.labelButton = labelButton
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(text)
                .lineLimit(expanded ? nil : lineLimit)
                .font(.manropeRegular(size: Grid.pt16))
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        let textHeight = geometry.size.height
                        let lineHeight: CGFloat = 18
                        let maxHeight = lineHeight * CGFloat(lineLimit)
                        textExceedsLimit = textHeight > maxHeight
                    }
                })
            
            if textExceedsLimit {
                Button {
                    withAnimation(nil) {
                        expanded.toggle()
                    }
                } label: {
                    labelButton(expanded)
                }
            }
        }
    }
}
