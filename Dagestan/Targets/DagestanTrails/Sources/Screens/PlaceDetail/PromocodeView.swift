//
//  PromocodeView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import CoreKit
import DesignSystem

struct PromocodeView<ViewModel: IPlaceDetailViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            title
            Spacer()
            itemContent
            Spacer()
        }
        .onAppear {
            viewModel.loadPromocode()
        }
    }
    
    @ViewBuilder
    private var itemContent: some View {
        if let promocodes = viewModel.promocodes.data {
            ForEach(promocodes, id: \.id) { promocode in
                VStack(spacing: 12) {
                    Text("\(promocode.value)")
                        .font(.manropeExtrabold(size: 20))
                        .foregroundColor(WFColor.accentPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(style: .init(lineWidth: 2, lineCap: .round, dash: [8]))
                                .foregroundColor(WFColor.accentPrimary)
                        }
                    
                    Text("Истекает: \(promocode.expiryDate)")
                        .font(.manropeSemibold(size: 16))
                        .foregroundColor(WFColor.foregroundSoft)
                }
            }
        } else if viewModel.promocodes.isLoading {
            Text("Loading...")
                .font(.manropeRegular(size: 20))
                .foregroundColor(WFColor.foregroundPrimary)
        }
    }
    
    private var title: some View {
        HStack {
            Text("Промокод")
                .font(.manropeSemibold(size: 24))
                .foregroundStyle(WFColor.foregroundPrimary)
            
            Spacer()
            
            CloseButton()
        }
        .padding()
    }
}
