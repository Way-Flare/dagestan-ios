//
//  SearchPlaceView.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import CoreKit

struct SearchPlaceListView: View {
    @StateObject private var searchViewModel: SearchViewModel
    let placeService: IPlacesService
    let routeService: IRouteService

    init(
        with places: [Place],
        placeService: IPlacesService,
        routeService: IRouteService,
        favoriteService: IFavoriteService
    ) {
        self._searchViewModel = StateObject(wrappedValue: SearchViewModel(places: places, favoriteService: favoriteService))
        self.placeService = placeService
        self.routeService = routeService
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if searchViewModel.places.isEmpty && !searchViewModel.searchText.isEmpty {
                    emptyStateView
                } else {
                    LazyVStack(alignment: .leading) {
                        ForEach(searchViewModel.places, id: \.id) { place in
                            PlaceView(
                                place: .constant(place),
                                isLoading: searchViewModel.isFavoritePlacesLoading[place.id] == true,
                                placeService: placeService,
                                routeService: routeService,
                                needClose: false
                            ) {
                                searchViewModel.setFavorite(by: place.id)
                            }
                            .buttonStyle(.plain)
                            .alert("Произошла ошибка", isPresented: $searchViewModel.showFavoriteAlert) {
                                Button("Понятно", role: .cancel) {}
                            } message: {
                                if let error = searchViewModel.favoriteState.error {
                                    Text(error)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .setCustomNavigationBarTitle(title: "Поиск мест")
            .setCustomBackButton { CloseButton() }
            .scrollIndicators(.hidden)
            .endEditingOnTap()
            .searchable(text: $searchViewModel.searchText, prompt: "Введите название места")
            .background(WFColor.surfaceSecondary, ignoresSafeAreaEdges: .all)
        }
    }
}

extension SearchPlaceListView {
    @ViewBuilder private var emptyStateView: some View {
        VStack(spacing: .zero) {
            DagestanTrailsAsset.searchEmpty.swiftUIImage
                .resizable()
                .frame(width: Grid.pt230, height: Grid.pt230)
            Text("Ничего не найдено")
                .font(.manropeExtrabold(size: Grid.pt16))
                .foregroundStyle(WFColor.foregroundPrimary)
        }
    }
}
