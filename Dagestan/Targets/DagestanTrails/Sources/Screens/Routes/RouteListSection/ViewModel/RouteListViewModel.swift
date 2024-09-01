//
//  RouteListViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

protocol IRouteListViewModel: ObservableObject {
    var path: NavigationPath { get set }
    var routeState: LoadingState<[Route]> { get }
    var favoriteState: LoadingState<Bool> { get }
    var routeService: IRouteService { get }
    var isFavoriteRoutesLoading: [Int: Bool] { get }

    func fetchRoutes()
    func setFavorite(by id: Int)
}

final class RouteListViewModel: IRouteListViewModel {
    @Published var path = NavigationPath()
    @Published var routeState: LoadingState<[Route]> = .idle
    @Published var favoriteState: LoadingState<Bool> = .idle
    @Published var isFavoriteRoutesLoading: [Int: Bool] = [:]

    let routeService: IRouteService
    let favoriteService: IFavoriteService

    init(routeService: IRouteService, favoriteService: IFavoriteService) {
        self.routeService = routeService
        self.favoriteService = favoriteService

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoriteUpdate(_:)),
            name: .didUpdateFavorites,
            object: nil
        )
    }

    func fetchRoutes() {
        routeState = .loading

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let fetchedRoutes = try await routeService.getAllRoutes()
                routeState = .loaded(fetchedRoutes)
            } catch {
                routeState = .failed(error.localizedDescription)
                print("Ошибка при получении данных: \(error)")
            }
        }
    }

    func setFavorite(by id: Int) {
        favoriteState = .loading
        updateFavoriteLoadingState(with: id, isLoading: true)

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let status = try await favoriteService.setFavorite(by: id, fromPlace: false)
                self.updateFavoriteStatus(for: id, to: status)
                updateFavoriteLoadingState(with: id, isLoading: false)
                favoriteState = .loaded(status)
            } catch {
                favoriteState = .failed(error.localizedDescription)
                print("Failed to set favorite: \(error.localizedDescription)")
                updateFavoriteLoadingState(with: id, isLoading: false)
            }
        }
    }

    private func updateFavoriteStatus(for id: Int, to status: Bool) {
        if let routes = routeState.data {
            if let index = routes.firstIndex(where: { $0.id == id }) {
                var updatedRoutes = routes
                var updatedRoute = updatedRoutes[index]
                updatedRoute = updatedRoute.withFavoriteStatus(to: status)
                updatedRoutes[index] = updatedRoute
                routeState = .loaded(updatedRoutes)
            }
        }
    }

    private func updateFavoriteLoadingState(with id: Int, isLoading: Bool) {
        isFavoriteRoutesLoading[id] = isLoading
    }

    @objc private func handleFavoriteUpdate(_ notification: Notification) {
        guard let updater = notification.object as? FavoriteUpdater else { return }

        if updater.type == .routes {
            updateFavoriteStatus(for: updater.id, to: updater.status)
        }
    }
}
