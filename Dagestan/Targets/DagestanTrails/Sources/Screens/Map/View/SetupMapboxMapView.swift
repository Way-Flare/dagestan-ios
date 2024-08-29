//
//  SetupMapboxMapView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import MapboxMaps
import SwiftUI
import DesignSystem

/// Настройка карты MapBox'a
extension MapView {

    // MARK: - Public methods

    /// Настройка слоев карты
    func setupMap(_ proxy: MapProxy) {
        guard let map = proxy.map else { return }

        do {
            try setupLayers(map)
        } catch {
            print("Failed to set up clustering layer: \(error)")
        }
    }

    /// Отлавливает нажатие на карту и проерят тап на кластер. При успехе зумит карту к кластеру
    func handleTap(proxy: MapProxy, feature: QueriedFeature, context: MapContentGestureContext) -> Bool {
        guard let map = proxy.map,
              case let .point(clusterCenter) = feature.feature.geometry else { return false }

        map.getGeoJsonClusterExpansionZoom(forSourceId: MapLayerId.source, feature: feature.feature) { result in
            switch result {
                case let .success(zoom):
                    viewModel.setupViewport(
                        coordinate: clusterCenter.coordinates,
                        zoomLevel: zoom.value as? CGFloat ?? map.cameraState.zoom + 1
                    )
                case let .failure(error):
                    print("An error occurred: \(error.localizedDescription)")
            }
        }
        return true
    }

    /// Получает точки в geoJson и обновляет с новыми данными карту
    func updatePlaces(_ proxy: MapProxy) {
        guard let map = proxy.map, let geoJSONData = viewModel.placesAsGeoJSON() else { return }
        let geoJSON = try? JSONDecoder().decode(GeoJSONObject.self, from: geoJSONData)
        if let geoJSON = geoJSON {
            map.updateGeoJSONSource(withId: MapLayerId.source, geoJSON: geoJSON)
        }
    }

    /// Обновить слой для отображения НЕкластеризованных точек. Нужен чтоб обновлять точки при смене стиля/типа карты
    func updateUnclusteredLayer(_ proxy: MapProxy) {
        do {
            if let map = proxy.map {
                try map.updateLayer(withId: MapLayerId.point, type: SymbolLayer.self) { (layer: inout SymbolLayer) throws in
                    layer = setupUnclusteredLayer(layer: layer)
                }
            }
        } catch {
            print("Updating the layer failed: \(error.localizedDescription)")
        }
    }

    // MARK: - Private methods

    /// Создать и настроить слои карт
    private func setupLayers(_ map: MapboxMap) throws {
        guard let locationIcon = UIImage(named: "Pinishe")
        else { return }

        try map.addImage(locationIcon, id: "place-icon", sdf: false)

        var source = GeoJSONSource(id: MapLayerId.source)
        source.cluster = true
        source.clusterRadius = 40

        let clusteredLayer = createClusteredLayer()
        let unclusteredLayer = createUnclusteredLayer()
        let clusterCountLayer = createNumberLayer()

        try map.addSource(source)
        try map.addLayer(clusteredLayer)
        try map.addLayer(unclusteredLayer, layerPosition: LayerPosition.below(clusteredLayer.id))
        try map.addLayer(clusterCountLayer)
    }

    /// Создать слой для отображения кластеризованных точек
    private func createClusteredLayer() -> CircleLayer {
        var layer = CircleLayer(id: MapLayerId.clusterCircle, source: MapLayerId.source)
        layer.circleStrokeWidth = .constant(2.0)
        layer.circleStrokeColor = .constant(StyleColor(UIColor(WFColor.iconInverted)))
        // Определяем цвет кластерного кружочка в зависимости от количества точек в кластере
        layer.circleColor = .expression(Exp(.step) {
            Exp(.get) { "point_count" }
            UIColor(WFColor.iconAccent)
            50
            UIColor(WFColor.infoActive)
            100
            UIColor(WFColor.errorSoft)
        })
        layer.circleRadius = .constant(15)
        layer.filter = Exp(.has) { "point_count" }
        return layer
    }

    /// Создание слоя для отображение чисел на кластеризованных точках
    private func createNumberLayer() -> SymbolLayer {
        var layer = SymbolLayer(id: MapLayerId.count, source: MapLayerId.source)
        layer.textColor = .constant(StyleColor(UIColor(WFColor.iconInverted)))
        layer.textField = .expression(Exp(.get) { "point_count" })
        layer.textSize = .constant(Grid.pt12)
        layer.filter = Exp(.has) { "point_count" }
        return layer
    }

    /// Создать слой для отображения НЕкластеризованных точек
    private func createUnclusteredLayer() -> SymbolLayer {
        var layer = SymbolLayer(id: MapLayerId.point, source: MapLayerId.source)
        layer = setupUnclusteredLayer(layer: layer)
        return layer
    }

    /// Настроить слой для отображения НЕкластеризованных точек
    private func setupUnclusteredLayer(layer: SymbolLayer) -> SymbolLayer {
        var newLayer = layer

        newLayer.textColor = .constant(layersTextColor)
        newLayer.textSize = .constant(Grid.pt12)
        newLayer.textAnchor = .constant(.top)
        newLayer.iconAnchor = .constant(.bottom)
        newLayer.textField = .expression(Exp(.get) { "place_name" })
        newLayer.iconImage = .constant(.name("place-icon"))
        newLayer.textAllowOverlap = .constant(true)
        newLayer.iconAllowOverlap = .constant(true)
        newLayer.filter = Exp(.not) { Exp(.has) { "point_count" } }

        return newLayer
    }

}
