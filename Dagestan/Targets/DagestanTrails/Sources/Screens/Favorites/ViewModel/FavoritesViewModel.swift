//
//  FavoritesViewModel.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 31.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

/// Структура состояния `isFavorite` у мест и маршрутов. Прокидывается на экран карт через нотификейшн центр
struct FavoriteUpdater {
    let type: FavoriteSection
    let id: Int
    let status: Bool
}

protocol IFavoriteListViewModel: ObservableObject {
    /// Словарь мест со значением обновляется ли у них сейчас isFavorite
    var isFavoritePlacesLoading: [Int: Bool] { get set }
    /// Словарь маршрутов со значением обновляется ли у них сейчас isFavorite
    var isFavoriteRoutesLoading: [Int: Bool] { get set }
    
    /// Загрузить места
    func loadPlaces()
    /// Загрузить маршруты
    func loadRoutes()
    /// Обновить состояние избранного
    /// - Parameter id: id места/маршрута
    func setFavorite(by id: Int)
}

final class FavoriteListViewModel: IFavoriteListViewModel {
    @Published var section: FavoriteSection = .places
    @Published var routesState: LoadingState<[Route]> = .idle
    @Published var placesState: LoadingState<[Place]> = .idle
    @Published var favoriteState: LoadingState<Bool> = .idle
    @Published var isFavoritePlacesLoading: [Int: Bool] = [:]
    @Published var isFavoriteRoutesLoading: [Int: Bool] = [:]

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
                fetchedPlaces.forEach {
                    self.updateFavoriteLoadingState(with: $0.id, isLoading: false, forPlace: true)
                }
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
                fetchedRoutes.forEach {
                    self.updateFavoriteLoadingState(with: $0.id, isLoading: false, forPlace: false)
                }
            } catch {
                self.routesState = .failed(error.localizedDescription)
                print("Ошибка при получении данных: \(error)")
            }
        }
    }

    func setFavorite(by id: Int) {
        favoriteState = .loading
        updateFavoriteLoadingState(with: id, isLoading: true, forPlace: section == .places)

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let status = try await favoriteService.setFavorite(by: id, fromPlace: section == .places)
                self.favoriteState = .loaded(status)
                updateFavoriteStatus(for: id, to: status)
                updateFavoriteLoadingState(with: id, isLoading: false, forPlace: section == .places)
                NotificationCenter.default.post(name: .didUpdateFavorites, object: FavoriteUpdater(type: section, id: id, status: status))
            } catch {
                self.favoriteState = .failed(error.localizedDescription)
                updateFavoriteLoadingState(with: id, isLoading: false, forPlace: section == .places)
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

    private func updateFavoriteLoadingState(with id: Int, isLoading: Bool, forPlace: Bool) {
        if forPlace {
            isFavoritePlacesLoading[id] = isLoading
        } else {
            isFavoriteRoutesLoading[id] = isLoading
        }
    }
}
