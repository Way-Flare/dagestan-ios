//
//  MapUIBox.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.04.2024.
//

import SwiftUI
@_spi(Experimental)
import MapboxMaps
import DesignSystem

private enum ItemId {
    static let clusterCircle = "clustered-circle-layer"
    static let point = "unclustered-point-layer"
    static let count = "cluster-count-layer"
    static let source = "place-source"
}

struct MapView<ViewModel: IMapViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        MapReader { proxy in
            ZStack {
                Map(viewport: $viewModel.viewport) {
                    ForEvery(viewModel.filteredPlaces) { place in
                        MapViewAnnotation(coordinate: place.coordinate) {
                            AnnotationView(name: place.name, workingTime: place.workTime, tagPlace: place.tags?.first)
                                .onTapGesture {
                                    viewModel.selectPlace(by: place.id)
                                }
                        }
                        .allowOverlap(true)
                    }
                }
                .mapStyle(.streets)
                .onStyleLoaded { _ in setupMap(proxy) }
                .onLayerTapGesture(ItemId.clusterCircle) { feature, context in
                    handleTap(proxy: proxy, feature: feature, context: context)
                }
                .onLayerTapGesture(ItemId.point) { feature, _ in
                    viewModel.selectPlace(by: feature.feature)
                    return true
                }
                .onChange(of: viewModel.filteredPlaces) { _ in updatePlaces(proxy) }
            }
            .overlay(alignment: .bottom) { bottomContentContainerView }
            .overlay(alignment: .trailing) {
                WFButtonIcon(
                    icon: DagestanTrailsAsset.location.swiftUIImage,
                    size: .m,
                    type: .nature
                ) {
                    viewModel.moveToDagestan()
                }
                .padding(.trailing, Grid.pt12)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

    private var bottomContentContainerView: some View {
        Group {
            if viewModel.selectedPlace == nil  {
                tagsContainerView
            } else {
                PlaceView(place: $viewModel.selectedPlace, service: viewModel.service)
                    .padding(.bottom, Grid.pt12)
            }
        }
    }

    private var tagsContainerView: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal) {
                HStack(spacing: Grid.pt8) {
                    Spacer()
                    ForEach(TagPlace.allCases.dropLast(), id: \.name) { tag in
                        WFChips(icon: tag.icon, name: tag.name) {
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

extension MapView {
    private func setupMap(_ proxy: MapProxy) {
        guard let map = proxy.map else { return }

        do {
            try setupClusteringLayer(map)
        } catch {
            print("Failed to set up clustering layer: \(error)")
        }
    }

    private func handleTap(proxy: MapProxy, feature: QueriedFeature, context: MapContentGestureContext) -> Bool {
        guard let map = proxy.map,
              case let .point(clusterCenter) = feature.feature.geometry else { return false }

        map.getGeoJsonClusterExpansionZoom(forSourceId: ItemId.source, feature: feature.feature) { result in
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

    private func updatePlaces(_ proxy: MapProxy) {
        guard let map = proxy.map, let geoJSONData = viewModel.placesAsGeoJSON() else { return }
        let geoJSON = try? JSONDecoder().decode(GeoJSONObject.self, from: geoJSONData)
        if let geoJSON = geoJSON {
            map.updateGeoJSONSource(withId: ItemId.source, geoJSON: geoJSON)
        }
    }

    private func setupClusteringLayer(_ map: MapboxMap) throws {
        let resize = CGSize(width: Grid.pt32, height: Grid.pt32)
        guard let resizedImage = UIImage(named: "location")?
            .withTintColor(.init(WFColor.iconAccent))
            .resized(to: resize)
        else { return }

        try map.addImage(resizedImage, id: "place-icon", sdf: true)

        var source = GeoJSONSource(id: ItemId.source)
        source.cluster = true
        source.clusterRadius = 50

        let clusteredLayer = createClusteredLayer()
        let unclusteredLayer = createUnclusteredLayer()
        let clusterCountLayer = createNumberLayer()

        try map.addSource(source)
        try map.addLayer(clusteredLayer)
        try map.addLayer(unclusteredLayer, layerPosition: LayerPosition.below(clusteredLayer.id))
        try map.addLayer(clusterCountLayer)
    }

    private func createClusteredLayer() -> CircleLayer {
        var layer = CircleLayer(id: ItemId.clusterCircle, source: ItemId.source)
        layer.circleStrokeWidth = .constant(2.0)
        layer.circleStrokeColor = .constant(StyleColor(UIColor(WFColor.iconInverted)))
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

    private func createUnclusteredLayer() -> SymbolLayer {
        var layer = SymbolLayer(id: ItemId.point, source: ItemId.source)
        layer.iconImage = .constant(.name("place-icon"))
        layer.iconColor = .constant(StyleColor(UIColor(WFColor.iconAccent)))
        layer.filter = Exp(.not) { Exp(.has) { "point_count" } }
        return layer
    }

    private func createNumberLayer() -> SymbolLayer {
        var layer = SymbolLayer(id: ItemId.count, source: ItemId.source)
        layer.textColor = .constant(StyleColor(UIColor(WFColor.iconInverted)))
        layer.textField = .expression(Exp(.get) { "point_count" })
        layer.textSize = .constant(Grid.pt12)
        layer.filter = Exp(.has) { "point_count" }
        return layer
    }
}
