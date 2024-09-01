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
        NavigationStack(path: $viewModel.path) {
            getContentView()
                .scrollIndicators(.hidden)
                .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
                .navigationTitle("Маршруты")
                .onViewDidLoad {
                    viewModel.fetchRoutes()
                }
                .navigationDestination(for: RouteListNavigation.self) { navPath in
                    switch navPath {
                        case .routeDetail(let id):
                            RouteDetailView(
                                viewModel: RouteDetailViewModel(
                                    service: viewModel.routeService,
                                    id: id
                                ),
                                placeService: placeService,
                                onFavoriteAction: {
                                    viewModel.setFavorite(by: id)
                                }
                            )
                    }
                }
        }
    }

    @ViewBuilder func getContentView() -> some View {
        if let routes = viewModel.routeState.data {
            ScrollView {
                LazyVStack(spacing: Grid.pt12) {
                    ForEach(routes, id: \.id) { route in
                        RouteCardView(
                            route: route,
                            isLoading: viewModel.isFavoriteRoutesLoading[route.id] ?? false
                        ) {
                            viewModel.setFavorite(by: route.id)
                        } didTapOnImage: {
                            viewModel.path.append(RouteListNavigation.routeDetail(id: route.id))
                        }
                        .onTapGesture {
                            viewModel.path.append(RouteListNavigation.routeDetail(id: route.id))
                        }
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
