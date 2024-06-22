//
//  StretchableView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 22.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct StretchableHeaderScrollView<Header: View, Content: View>: View {
    let header: () -> Header
    let content: () -> Content

    init(
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.header = header
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 12) {
                    GeometryReader { innerGeometry in
                        let minY = innerGeometry.frame(in: .global).minY
                        header()
                            .frame(width: geometry.size.width, height: max(geometry.size.width * 0.6, geometry.size.width * 0.6 + (minY > 0 ? minY : 0)))
                            .clipped()
                            .offset(y: minY > 0 ? -minY : 0)
                    }
                    .frame(height: geometry.size.width * 0.6)

                    content()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    StretchableHeaderScrollView {
        DagestanTrailsAsset.connectionFavorites.swiftUIImage
    } content: {
        Text("asdfpoaskgpoasgg")
    }
}
