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
        if let routes = viewModel.routeState.data {
            ScrollView {
                LazyVStack(spacing: Grid.pt12) {
                    ForEach(routes, id: \.id) { route in
                        NavigationLink(
                            destination: RouteDetailView(
                                viewModel: RouteDetailViewModel(
                                    service: viewModel.routeService,
                                    id: route.id
                                ),
                                placeService: placeService,
                                onFavoriteAction: {
                                    viewModel.setFavorite(by: route.id)
                                }
                            )
                        ) {
                            RouteCardView(route: route, isLoading: viewModel.favoriteState.isLoading) {
                                viewModel.setFavorite(by: route.id)
                            }
                        }
                        .buttonStyle(DSPressedButtonStyle())
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, Grid.pt12)
            }
        } else if viewModel.routeState.isError {
            FailedLoadingView {
                viewModel.fetchRoutes()
            }
        } else {
            ShimmerRouteListView()
        }
    }
}
