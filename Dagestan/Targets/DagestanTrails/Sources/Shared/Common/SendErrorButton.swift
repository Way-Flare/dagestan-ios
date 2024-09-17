//
//  SendErrorButton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct SendErrorButton: View {
    @State private var showingContactsSheet = false

    var body: some View {
        Button(action: { showingContactsSheet.toggle() }) {
            if #available(iOS 16.4, *) {
                SendErrorView()
                    .sheet(isPresented: $showingContactsSheet) {
                        CompanyContactsView()
                            .presentationCornerRadius(Grid.pt32)
                            .intrincsicHeightSheet()
                            .background(WFColor.surfaceQuaternary)
                    }
            } else {
                SendErrorView()
                    .sheet(isPresented: $showingContactsSheet) {
                        CompanyContactsView()
                            .intrincsicHeightSheet()
                            .background(WFColor.surfaceQuaternary)
                    }
            }
        }
    }
}

private struct SendErrorView: View {
    let action: (() -> Void)?
    
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    var body: some View {
        contentView
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

//#Preview {
//   SendErrorButton()
//}
