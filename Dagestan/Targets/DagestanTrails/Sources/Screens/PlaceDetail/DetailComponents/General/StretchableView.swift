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
    @Binding var scrollViewOffset: CGFloat // Отслеживание позиции прокрутки

    init(
        showsBackdrop: Binding<Bool>,
        scrollViewOffset: Binding<CGFloat>,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _showsBackdrop = showsBackdrop
        _scrollViewOffset = scrollViewOffset
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
                            .onChange(of: minY) { value in
                                showsBackdrop = value < 0
                                scrollViewOffset = value
                            }
                    }
                    .frame(height: geometry.size.width * 0.6)

                    content()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
