//
//  FavoritesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import DesignSystem
import SwiftUI

struct FavoriteUpdater {
    let type: FavoriteSection
    let id: Int
    let status: Bool
}

protocol IFavoriteListViewModel: ObservableObject {
    func loadPlaces()
    func loadRoutes()
    func setFavorite(by id: Int)
}

class FavoriteListViewModel: IFavoriteListViewModel {
    @Published var section: FavoriteSection = .places
    @Published var routesState: LoadingState<[Route]> = .idle
    @Published var placesState: LoadingState<[Place]> = .idle
    @Published var favoriteState: LoadingState<Bool> = .idle

    let placeService: IPlacesService
    let routeService: IRouteService
    let favoriteService: IFavoriteService

    init(
        placeService: IPlacesService,
        routeService: IRouteService,
        favoriteService: IFavoriteService
    ) {
        self.placeService = placeService
        self.routeService = routeService
        self.favoriteService = favoriteService
    }

    func loadPlaces() {
        placesState = .loading

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let fetchedPlaces = try await placeService.getAllPlaces()
                self.placesState = .loaded(fetchedPlaces.filter { $0.isFavorite })
            } catch {
                self.placesState = .failed(error.localizedDescription)
                print("Ошибка при получении данных: \(error)")
            }
        }
    }

    func loadRoutes() {
        routesState = .loading

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let fetchedRoutes = try await routeService.getAllRoutes()
                self.routesState = .loaded(fetchedRoutes.filter { $0.isFavorite })
            } catch {
                self.routesState = .failed(error.localizedDescription)
                print("Ошибка при получении данных: \(error)")
            }
        }
    }

    func setFavorite(by id: Int) {
        favoriteState = .loading

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let status = try await favoriteService.setFavorite(by: id, fromPlace: section == .places)
                self.favoriteState = .loaded(status)
                updateFavoriteStatus(for: id, to: status)
                
                NotificationCenter.default.post(name: .didUpdateFavorites, object: FavoriteUpdater(type: section, id: id, status: status))

            } catch {
                self.favoriteState = .failed(error.localizedDescription)
                print("Failed to set favorite: \(error.localizedDescription)")
            }
        }
    }

    private func updateFavoriteStatus(for id: Int, to status: Bool) {
        switch section {
            case .places:
                updateFavoriteStatusForPlaces(for: id, to: status)
            case .routes:
                updateFavoriteStatusForRoutes(for: id, to: status)
        }
    }

    private func updateFavoriteStatusForRoutes(for id: Int, to status: Bool) {
        if let routes = routesState.data {
            if let index = routes.firstIndex(where: { $0.id == id }) {
                var updatedRoutes = routes
                var updatedRoute = updatedRoutes[index]
                updatedRoute = updatedRoute.withFavoriteStatus(to: status)
                updatedRoutes[index] = updatedRoute
                routesState = .loaded(updatedRoutes.filter { $0.isFavorite })
            }
        }
    }

    private func updateFavoriteStatusForPlaces(for id: Int, to status: Bool) {
        if let places = placesState.data {
            if let index = places.firstIndex(where: { $0.id == id }) {
                var updatedPlaces = places
                var updatedPlace = updatedPlaces[index]
                updatedPlace = updatedPlace.withFavoriteStatus(to: status)
                updatedPlaces[index] = updatedPlace
                placesState = .loaded(updatedPlaces.filter { $0.isFavorite })
            }
        }
    }
}

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
                                            FavoriteCardView(place: place, isLoading: viewModel.favoriteState.isLoading) {
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
                                            RouteCardView(route: route, isLoading: viewModel.favoriteState.isLoading) {
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
