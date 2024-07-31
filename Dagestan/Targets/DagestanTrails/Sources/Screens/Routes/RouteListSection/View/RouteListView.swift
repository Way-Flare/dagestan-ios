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
    let placeService: IPlacesService
    let onFavoriteAction: (() -> Void)?

    var body: some View {
        NavigationStack {
            getContentView()
                .scrollIndicators(.hidden)
                .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
                .navigationTitle("Маршруты")
                .onViewDidLoad {
                    viewModel.fetchRoutes()
                }
        }
    }

    @ViewBuilder func getContentView() -> some View {
        if let routes = viewModel.state.data {
            ScrollView {
                LazyVStack(spacing: Grid.pt12) {
                    ForEach(routes, id: \.id) { route in
                        NavigationLink(
                            destination: RouteDetailView(
                                viewModel: RouteDetailViewModel(
                                    service: viewModel.service,
                                    id: route.id
                                ),
                                placeService: placeService,
                                onFavoriteAction: onFavoriteAction
                            )
                        ) {
                            RouteCardView(route: route, onFavoriteAction: onFavoriteAction)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, Grid.pt12)
            }
        } else if viewModel.state.isError {
            FailedLoadingView {
                viewModel.fetchRoutes()
            }
        } else {
            ShimmerRouteListView()
        }
    }
}
