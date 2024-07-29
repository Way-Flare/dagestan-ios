//
//  ShimmerDetailView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 30.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ShimmerRouteDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                makeRectangle(height: 298)
                    .cornerStyle(.constant(12, .bottomCorners))
                
                makeRectangle(height: 48)
                    .cornerStyle(.constant(12))
                    .padding(.horizontal, 12)
                
                makeRectangle(height: 44)
                    .cornerStyle(.constant(12))
                    .padding(.horizontal, 12)
                
                makeRectangle(height: 135)
                    .cornerStyle(.constant(12))
                    .padding(.horizontal, 12)
                
                makeRectangle(width: 193, height: 24)
                    .cornerStyle(.constant(4))
                    .padding(.horizontal, 12)

                ForEach(0..<3) { _ in
                    makeRectangle(height: 60)
                        .cornerStyle(.constant(8))
                        .padding(.horizontal, 12)
                }
                
                makeRectangle(height: 44)
                    .cornerStyle(.constant(12))
                    .padding(.horizontal, 12)
                
                makeRectangle(height: 253)
                    .cornerStyle(.constant(12))
                    .padding(.horizontal, 12)
                
                makeRectangle(height: 76)
                    .cornerStyle(.constant(8))
                    .padding(.horizontal, 12)
                
                makeRectangle(width: 156, height: 20)
                    .cornerStyle(.constant(4))
                    .padding(.horizontal, 12)

                makeRectangle(height: 221)
                    .cornerStyle(.constant(12))
                    .padding(.horizontal, 12)
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .edgesIgnoringSafeArea(.top)
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
    ShimmerRouteDetailView()
}
