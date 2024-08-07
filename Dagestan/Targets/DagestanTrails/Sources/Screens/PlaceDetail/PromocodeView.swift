//
//  PromocodeView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import DesignSystem
import SwiftUI

struct PromocodeView<ViewModel: IPlaceDetailViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: Grid.pt12) {
            title
            itemContent
        }
        .onAppear {
            setupAppearance()
            viewModel.loadPromocode()
        }
    }
    
    @ViewBuilder
    private var itemContent: some View {
        if let promocodes = viewModel.promocodes.data {
            TabView {
                ForEach(promocodes, id: \.id) { promocode in
                    promocodeCard(for: promocode)
                }
                .padding(Grid.pt12)
            }
            .edgesIgnoringSafeArea(.bottom)
            .tabViewStyle(.page(indexDisplayMode: promocodes.count > 1 ? .always : .never))
        } else if viewModel.promocodes.isLoading {
            ShimmerPromocodeView()
        }
    }
    
    private var title: some View {
        HStack {
            Text("Промокод")
                .font(.manropeSemibold(size: Grid.pt24))
                .foregroundStyle(WFColor.foregroundPrimary)
            
            Spacer()
            
            CloseButton()
        }
        .padding()
    }
    
    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = WFColor.foregroundInverted.uiColor()
        UIPageControl.appearance().pageIndicatorTintColor = WFColor.foregroundInverted.uiColor().withAlphaComponent(0.2)
    }
    
    private func promocodeCard(for promocode: Promocode) -> some View {
        VStack(spacing: 12) {
            Text("\(promocode.value)")
                .font(.manropeExtrabold(size: Grid.pt20))
                .foregroundColor(WFColor.accentPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(16)
                .overlay {
                    RoundedRectangle(cornerRadius: Grid.pt12)
                        .stroke(style: .init(lineWidth: 2, lineCap: .round, dash: [8]))
                        .foregroundColor(WFColor.accentPrimary)
                }
            
            Text("Истекает: \(promocode.expiryDate)")
                .font(.manropeSemibold(size: Grid.pt16))
                .foregroundColor(WFColor.foregroundSoft)
        }
    }
}
