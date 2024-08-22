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
    @Binding var showsBackdrop: Bool // Переменная для управления видимостью подложки
    private let sizeCof = 1.2

    init(
        showsBackdrop: Binding<Bool>,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _showsBackdrop = showsBackdrop
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
                            .frame(width: geometry.size.width, height: max(geometry.size.width * sizeCof, geometry.size.width * sizeCof + (minY > 0 ? minY : 0)))
                            .clipped()
                            .offset(y: minY > 0 ? -minY : 0)
                            .onChange(of: minY) { value in
                                showsBackdrop = value < 0
                            }
                    }
                    .frame(height: geometry.size.width * sizeCof)

                    content()
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .clipped()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
