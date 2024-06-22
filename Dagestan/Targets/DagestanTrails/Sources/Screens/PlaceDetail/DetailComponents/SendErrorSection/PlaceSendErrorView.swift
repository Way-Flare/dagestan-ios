//
//  PlaceSendErrorView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct PlaceSendErrorView: View {
    let action: (() -> Void)?
    
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            contentView
        }
    }
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: Grid.pt12) {
            Divider()
                .background(WFColor.borderMuted)
                .frame(height: Grid.pt16)
            HStack(spacing: Grid.pt8) {
                DagestanTrailsAsset.flagLinear.swiftUIImage
                    .resizable()
                    .frame(width: Grid.pt20, height: Grid.pt20)
                    .foregroundStyle(WFColor.foregroundMuted)
                Text("Доложить об ошибке")
                    .font(.manropeRegular(size: Grid.pt16))
                    .foregroundStyle(WFColor.iconMuted)
            }
            Divider()
                .background(WFColor.borderMuted)
                .frame(height: Grid.pt16)
        }
    }
}

#Preview {
    PlaceSendErrorView()
}
