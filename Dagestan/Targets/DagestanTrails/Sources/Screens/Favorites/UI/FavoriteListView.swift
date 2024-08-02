//
//  FavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import DesignSystem
import SwiftUI

struct FavoriteListView: View {
    @ObservedObject var viewModel: FavoriteListViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: Grid.pt12) {
                counterContainerView
                
                WFSegmentedPickerView(selection: $viewModel.section) { section in
                    contentView(for: section)
                }
            }
            .background(WFColor.surfacePrimary, ignoresSafeAreaEdges: .all)
            .onAppear {
                viewModel.loadPlaces()
                viewModel.loadRoutes()
            }
        }
    }

    private var counterContainerView: some View {
        HStack(spacing: Grid.pt6) {
            Text("Избранное")
                .foregroundStyle(WFColor.foregroundPrimary)
                .font(.manropeExtrabold(size: Grid.pt20))
            WFCounter(style: .nature, size: .m, number: 5)
            Spacer()
        }
        .padding(.horizontal, Grid.pt12)
        .padding(.vertical, Grid.pt14)
    }

    private var emptyStateContainerView: some View {
        StateFavoritesView(
            image: DagestanTrailsAsset.emptyFavorites.swiftUIImage,
            title: "Сейчас тут пусто",
            message: "Мы покажем тут места и маршруты, которые ты добавишь в избранное"
        )
    }

    private var connectionStateContainerView: some View {
        StateFavoritesView(
            image: DagestanTrailsAsset.connectionFavorites.swiftUIImage,
            title: "Плохое соеденение",
            message: "Проверь доступ к интернету и обнови страницу"
        )
    }

    @ViewBuilder
    private func contentView(for section: FavoriteSection) -> some View {
        ScrollView {
            Group {
                switch section {
                    case .places:
                        Group {
                            if let places = viewModel.placesState.data {
                                LazyVStack(spacing: Grid.pt12) {
                                    ForEach(places, id: \.id) { place in
                                        NavigationLink(
                                            destination: PlaceDetailView(
                                                viewModel: PlaceDetailViewModel(
                                                    service: viewModel.placeService,
                                                    placeId: place.id,
                                                    isFavorite: place.isFavorite
                                                ),
                                                routeService: viewModel.routeService,
                                                onFavoriteAction: {
                                                    viewModel.setFavorite(by: place.id)
                                                }
                                            )
                                        ) {
                                            FavoriteCardView(
                                                place: place,
                                                isLoading: viewModel.isFavoritePlacesLoading[place.id] ?? false
                                            ) {
                                                viewModel.setFavorite(by: place.id)
                                            }
                                        }
                                    }
                                }
                            } else {
                                ShimmerRouteListView()
                            }
                        }
                    case .routes:
                        Group {
                            if let routes = viewModel.routesState.data {
                                LazyVStack(spacing: Grid.pt12) {
                                    ForEach(routes, id: \.id) { route in
                                        NavigationLink(
                                            destination: RouteDetailView(
                                                viewModel: RouteDetailViewModel(
                                                    service: viewModel.routeService,
                                                    id: route.id
                                                ),
                                                placeService: viewModel.placeService,
                                                onFavoriteAction: {
                                                    viewModel.setFavorite(by: route.id)
                                                }
                                            )
                                        ) {
                                            RouteCardView(
                                                route: route,
                                                isLoading: viewModel.isFavoriteRoutesLoading[route.id] ?? false
                                            ) {
                                                viewModel.setFavorite(by: route.id)
                                            }
                                        }
                                    }
                                }
                            } else {
                                ShimmerRouteListView()
                            }
                        }
                }
            }
            .padding(.horizontal, Grid.pt12)
        }
        .scrollIndicators(.hidden)
    }
}
