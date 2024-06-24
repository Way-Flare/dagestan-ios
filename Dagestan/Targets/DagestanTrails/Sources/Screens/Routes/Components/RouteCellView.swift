//
//  RouteCellView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct RouteCellView: View {
    let rating: Double?
    let distance: Double
    let time: String
    
    var body: some View {
        HStack {
            HStack(spacing: Grid.pt8) {
                DagestanTrailsAsset.routingBulk.swiftUIImage
                    .resizable()
                    .frame(width: Grid.pt16, height: Grid.pt16)
                    .foregroundStyle(WFColor.iconAccent)
                
                Text(String(format: "%.3f", distance) + " км")
                Text("•")
                Text(formatExtendedTravelTime())
            }
            .font(.manropeRegular(size: Grid.pt14))
            .foregroundStyle(WFColor.foregroundSoft)
            
            Spacer()
            
            HStack(spacing: Grid.pt4) {
                StarsView(amount: Int(rating ?? .zero), size: .s, type: .review)
                Text(String(rating ?? .zero))
                    .font(.manropeRegular(size: 14))
                    .foregroundStyle(WFColor.foregroundSoft)
            }
        }
        .frame(height: 24)
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(12))
    }
    
    private func formatExtendedTravelTime() -> String {
        let components = time.split(separator: ":").map { Int($0) ?? 0 }
        
        if components.count == 3 {
            var hours = components[0]
            let minutes = components[1]
            
            let days = hours / 24
            hours %= 24
            
            var result = ""
            if days > 0 {
                result += "\(days)дн "
            }
            if hours > 0 || days > 0 {
                result += "\(hours)ч "
            }
            result += "\(minutes)мин"
            
            return result
        }
        
        return ""
    }
}

#Preview {
    RouteCellView(rating: 5.0, distance: 3.32, time: "3d 5h")
}
