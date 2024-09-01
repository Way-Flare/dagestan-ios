//
//  MapView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.04.2024.
//

import DesignSystem
import MapboxMaps
import MapboxCommon
import SwiftUI

/// Основное view c картой
struct MapView<ViewModel: IMapViewModel>: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    // MARK: - Initial props

    /// Вью модель для работы с экрном/модулем карт с местами
    @ObservedObject var viewModel: ViewModel
    /// Сервис для работы с маршрутами
    let routeService: IRouteService
    /// Модель данных, содержайщее визуальные настройки карты
    @EnvironmentObject var mapStyleModel: StandardStyleLocationsModel

    // MARK: - Local/private props

    /// Высота настроеек для выбора стиля карты
    @State var settingsHeight: CGFloat = 0
    /// Отображать ли селектор типа карты
    @State var isShowMapStyleSelection = false
    /// Цвет текста под point'ом
    @State var layersTextColor: StyleColor = .init(UIColor(WFColor.foregroundPrimary))
    /// Стиль карты
    private var style: MapStyle {
        // Подбираем цвет текста под точкой в зависмости от стиля карты
        if mapStyleModel.lightPreset == .dusk || mapStyleModel.lightPreset == .night || mapStyleModel.style == .standardSatellite {
            layersTextColor = .init(.white)
        } else {
            layersTextColor = .init(UIColor(WFColor.foregroundPrimary))
        }
        switch mapStyleModel.style {
            case .standard:
                return .standard(
                    theme: mapStyleModel.theme,
                    lightPreset: mapStyleModel.lightPreset,
                    showPointOfInterestLabels: mapStyleModel.poi,
                    showTransitLabels: mapStyleModel.transitLabels,
                    showPlaceLabels: mapStyleModel.placeLabels,
                    showRoadLabels: mapStyleModel.roadLabels,
                    show3dObjects: mapStyleModel.show3DObjects
                )
            case .standardSatellite:
                return .standardSatellite(
                    lightPreset: mapStyleModel.lightPreset,
                    showPointOfInterestLabels: mapStyleModel.poi,
                    showTransitLabels: mapStyleModel.transitLabels,
                    showPlaceLabels: mapStyleModel.placeLabels,
                    showRoadLabels: mapStyleModel.roadLabels,
                    showRoadsAndTransit: mapStyleModel.showRoadsAndTransit,
                    showPedestrianRoads: mapStyleModel.showPedestrianRoads
                )
        }
    }

    // MARK: - Content View

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            MapReader { proxy in
                ZStack(alignment: .top) {
                    Map(viewport: $viewModel.viewport) {
                        Puck2D(bearing: .heading)
                    }
                    .mapStyle(style)
                    // Данный модифайр двигает карту наверх, тем самым также поднимая/спуская вспомогательные view(айка и надпись mapbox)
                    .additionalSafeAreaInsets(.bottom, settingsHeight) // Добавляем отступ снизу для view с настройкой стиля карты
                    .ornamentOptions(OrnamentOptions( // Настройка расположения компаса
                        compass: CompassViewOptions(
                            position: .bottomTrailing,
                            margins: .init(x: Grid.pt8, y: Grid.pt56)
                        )
                    ))
                    .onMapLoaded { _ in updatePlaces(proxy) } // Обновить места на карте, когда завершилась полность прогрузка карты
                    .onStyleLoaded { _ in setupMap(proxy) } // Настраиваем карту по новой при изменении стиля карты
                    .onLayerTapGesture(MapLayerId.clusterCircle) { feature, context in // Отлавливаем нажатие на слой кластера
                        handleTap(proxy: proxy, feature: feature, context: context)
                    }
                    .onLayerTapGesture(MapLayerId.point) { feature, _ in // Отлавливаем нажатие на слой точек
                        viewModel.selectPlace(by: feature.feature, zoom: proxy.map?.cameraState.zoom)
                        return true
                    }
                    .onChange(of: viewModel.filteredPlaces) { _ in updatePlaces(proxy) } // При изменении фильтра мест обновить места
                    .onChange(of: mapStyleModel.lightPreset) { _ in updateUnclusteredLayer(proxy) } // При изменении светового дня карты обновить слой некластеризованных точек

                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .overlay(alignment: .top) {
                    searchBar
                        .padding(.top, safeAreaInsets.top)
                }
                .overlay(alignment: .bottom) {
                    bottomContentContainerView
                        .isHidden(isShowMapStyleSelection)
                }
                .overlay(alignment: .bottom) {
                    mapStyleSelectionView
                        .isHidden(!isShowMapStyleSelection)
                }
                .overlay(alignment: .trailing) {
                    rightContainerButtons
                }
                .edgesIgnoringSafeArea(.top)
                .alert("Не удалось загрузить данные", isPresented: $viewModel.isShowAlert) {
                    Button("Да", role: .cancel) {
                        viewModel.loadPlaces()
                    }
                } message: {
                    Text("Повторить попытку?")
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.searchOpen) {
            SearchPlaceListView(
                with: viewModel.places,
                placeService: viewModel.placeService,
                routeService: routeService,
                favoriteService: viewModel.favoriteService
            )
        }
    }

}
