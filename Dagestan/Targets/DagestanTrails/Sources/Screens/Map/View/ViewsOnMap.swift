//
//  ViewsOnMap.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

/// Вьюшки отображаемые на карте
extension MapView {

    // MARK: - Public views

    /// Строка поиска
    var searchBar: some View {
        HStack(spacing: Grid.pt12) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: Grid.pt16, height: Grid.pt16)
                .foregroundStyle(WFColor.iconPrimary)
            Text("Искать место...")
                .font(.manropeSemibold(size: Grid.pt14))
                .foregroundStyle(WFColor.foregroundSoft)
            Spacer()
        }
        .frame(height: Grid.pt44)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Grid.pt12)
        .background(WFColor.surfaceSecondary)
        .cornerStyle(.constant(Grid.pt12))
        .onTapGesture {
            viewModel.searchOpen = true
        }
        .padding()
    }

    /// Набор кнопок справа: Выбор стиля карты; Навигация на Дагестан, Навигация на себя
    var rightContainerButtons: some View {
        VStack(alignment: .center, spacing: Grid.pt16) {
            WFButtonIcon(
                icon: Image(systemName: "square.3.layers.3d.middle.filled"),
                size: .m,
                type: .nature
            ) {
                isShowMapStyleSelection.toggle()
            }
            WFButtonIcon(
                icon: DagestanTrailsAsset.location.swiftUIImage,
                size: .m,
                type: .nature
            ) {
                viewModel.moveToDagestan()
            }
            LocateMeButton(viewport:  $viewModel.viewport)
        }
        .padding(.trailing, Grid.pt12)
    }

    /// Вью с настройко стиля карты
    var mapStyleSelectionView: some View {
        MapStyleSelectionView(isPresented: $isShowMapStyleSelection)
            .floating(RoundedRectangle(cornerRadius: Grid.pt10))
            .limitPaneWidth()
            .background(GeometryReader { proxy in
                Color.clear
                    .onAppear { settingsHeight = proxy.size.height }
                    .onDisappear { settingsHeight = 0 }
            })
    }

    /// View контейнер с содержимым внизу карты: Фильтры, Плашка выбранного места
    var bottomContentContainerView: some View {
        Group {
            ZStack(alignment: .bottom) {
                tagsContainerView
                    .disabled(viewModel.selectedPlace != nil)
                if viewModel.selectedPlace != nil {
                    PlaceView(
                        place: $viewModel.selectedPlace,
                        isLoading: viewModel.favoriteState.isLoading
                    ) {
                        if let id = viewModel.selectedPlace?.id {
                            viewModel.setFavorite(by: id)
                        }
                    }
                    .onTapGesture {
                        viewModel.navigationPath.append(MapNavigationRoute.placeDetail(
                            id: viewModel.selectedPlace?.id ?? .zero,
                            isFavorite: viewModel.selectedPlace?.isFavorite ?? false
                        ))
                    }
                    .navigationDestination(for: MapNavigationRoute.self) { route in
                        switch route {
                            case .placeDetail(let id, let isFavorite):
                                let placeDetailViewModel = PlaceDetailViewModel(
                                    service: viewModel.placeService,
                                    placeInfo: .init(id: id, name: nil, coordinate: nil),
                                    isFavorite: isFavorite
                                )

                                PlaceDetailView(viewModel: placeDetailViewModel, routeService: routeService) {
                                    if let id = viewModel.selectedPlace?.id {
                                        viewModel.setFavorite(by: id)
                                    }
                                }
                        }
                    }
                    .padding(.bottom, Grid.pt8)
                    .alert("Произошла ошибка", isPresented: $viewModel.showFavoriteAlert) {
                        Button("Понятно", role: .cancel) {}
                    } message: {
                        if let error = viewModel.favoriteState.error {
                            Text(error)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Private views

    /// Фильтры/Теги
    private var tagsContainerView: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal) {
                HStack(spacing: Grid.pt8) {
                    Spacer()
                    ForEach(TagPlace.allCases.dropLast(), id: \.name) { tag in
                        WFChips(icon: tag.icon, name: tag.name, isActive: viewModel.selectedTags.contains(tag)) {
                            viewModel.toggleTag(tag)
                            if viewModel.selectedTags.contains(tag) {
                                withAnimation {
                                    value.scrollTo(tag.name, anchor: .center)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding(.bottom, Grid.pt4)
            .scrollIndicators(.hidden)
        }
    }

}
