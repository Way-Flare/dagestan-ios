//
//  SearchViewModel.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import CoreKit

final class SearchViewModel: ObservableObject {
    @Published var places: [Place] = [] {
        didSet {
            filteredPlaces = places
        }
    }
    @Published var filteredPlaces: [Place] = []
    @Published var favoriteState: LoadingState<Bool> = .idle
    @Published var showFavoriteAlert = false
    @Published var isFavoritePlacesLoading: [Int: Bool] = [:]
    @Published var selectedTags: Set<TagPlace> = []
    @Published var searchText = "" {
        didSet {
            filterPlaces()
        }
    }

    private var allPlaces: [Place] = []
    private let favoriteService: IFavoriteService

    init(places: [Place], favoriteService: IFavoriteService) {
        self.allPlaces = places
        self.places = places
        self.favoriteService = favoriteService
    }
    
    func setFavorite(by id: Int) {
        favoriteState = .loading
        isFavoritePlacesLoading[id] = true

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let status = try await favoriteService.setFavorite(by: id, fromPlace: true)
                self.updateFavoriteStatus(for: id, to: status)
                isFavoritePlacesLoading[id] = false
                favoriteState = .loaded(status)
                NotificationCenter.default.post(
                    name: .didUpdateFavorites,
                    object: FavoriteUpdater(type: .places, id: id, status: status)
                )
            } catch {
                self.showFavoriteAlert = true
                isFavoritePlacesLoading[id] = false

                if let error = error as? RequestError {
                    favoriteState = .failed(error.message)
                } else {
                    favoriteState = .failed(error.localizedDescription)
                }
                print("Failed to set favorite: \(error.localizedDescription)")
            }
        }
    }

    private func filterPlaces() {
        if searchText.isEmpty {
            places = allPlaces
        } else {
            places = allPlaces.filter { place in
                place.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        updateFilteredPlaces()
    }

    private func updateFavoriteStatus(for id: Int, to status: Bool) {
        if let index = places.firstIndex(where: { $0.id == id }) {
            var updatedPlace = places[index]
            updatedPlace = updatedPlace.withFavoriteStatus(to: status)
            places[index] = updatedPlace
        }
    }

    @objc
    private func handleFavoriteUpdate(_ notification: Notification) {
        guard let updater = notification.object as? FavoriteUpdater else { return }

        if updater.type == .places {
            updateFavoriteStatus(for: updater.id, to: updater.status)
        }
    }

    func updateFilteredPlaces() {
        if selectedTags.isEmpty {
            filteredPlaces = places
        } else {
            filteredPlaces = places.filter { place in
                !selectedTags.isDisjoint(with: place.tags ?? [])
            }
        }
    }

    func toggleTag(_ tag: TagPlace) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
        updateFilteredPlaces()
    }
}
