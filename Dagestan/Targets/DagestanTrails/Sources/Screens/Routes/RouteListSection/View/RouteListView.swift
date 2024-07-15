//
//  RouteListView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct RouteListView<ViewModel: IRouteListViewModel>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: Grid.pt12) {
                    ForEach(viewModel.routes, id: \.id) { route in
                        NavigationLink(
                            destination: RouteDetailView(
                                viewModel: RouteDetailViewModel(
                                    service: viewModel.service,
                                    id: route.id
                                )
                            )
                        ) {
                            RouteCardView(route: route)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, Grid.pt12)
            }
            .scrollIndicators(.hidden)
            .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
            .navigationTitle("Маршруты")
            .task {
                await viewModel.fetchRoutes()
            }
        }
    }
}
