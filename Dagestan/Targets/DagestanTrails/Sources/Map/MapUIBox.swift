//
//  MapUIBox.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
@_spi(Experimental)
import MapboxMaps

private enum ItemId {
    static let clusterCircle = "clustered-circle-layer"
    static let point = "unclustered-point-layer"
    static let count = "cluster-count-layer"
    static let source = "place-source"
}

struct MapUIBox: View {
    @StateObject private var mapViewModel = MapViewModel()
    @State private var viewport: Viewport = .idle
    
    var body: some View {
        MapReader { proxy in
            Map(viewport: $viewport)
                .mapStyle(.dark)
                .onStyleLoaded { _ in
                    setupMap(proxy: proxy)
                }
                .onLayerTapGesture(ItemId.clusterCircle) { _, context in
                    handleTap(proxy: proxy, context: context)
                }
        }
        .ignoresSafeArea()
    }
}

extension MapUIBox {
    private func setupMap(proxy: MapProxy) {
        guard let map = proxy.map else { return }
        
        do {
            try setupClusteringLayer(map)
        } catch {
            print("Failed to set up clustering layer: \(error)")
        }
    }
    
    private func handleTap(proxy: MapProxy, context: MapContentGestureContext) -> Bool {
        guard let map = proxy.map else { return false }
        animatingNewViewPort(map: map, coordinate: context.coordinate)
        return true
    }
    
    private func animatingNewViewPort(map: MapboxMap, coordinate: CLLocationCoordinate2D) {
        let newZoom = map.cameraState.zoom + 1
        withViewportAnimation(.fly) {
            viewport = .camera(center: coordinate, zoom: newZoom)
        }
    }
    
    private func setupClusteringLayer(_ map: MapboxMap) throws {
        let resize = CGSize(width: 32, height: 32)
        guard let resizedImage = UIImage(systemName: "square.and.arrow.up.circle")?
            .withRenderingMode(.alwaysTemplate).resized(to: resize) else { return }
        
        try map.addImage(resizedImage, id: "place-icon", sdf: true)
        
        guard let url = Bundle.main.url(forResource: "icons", withExtension: "geojson") else { return }
        
        var source = GeoJSONSource(id: ItemId.source)
        source.data = .url(url)
        
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
        layer.circleColor = .expression(Exp(.step) {
            Exp(.get) { "point_count" }
            UIColor.systemGreen
            50
            UIColor.systemBlue
            100
            UIColor.systemRed
        })
        layer.circleRadius = .constant(25)
        layer.filter = Exp(.has) { "point_count" }
        return layer
    }
    
    private func createUnclusteredLayer() -> SymbolLayer {
        var layer = SymbolLayer(id: ItemId.point, source: ItemId.source)
        layer.iconImage = .constant(.name("place-icon"))
        layer.iconColor = .constant(StyleColor(.white))
        layer.filter = Exp(.not) { Exp(.has) { "point_count" } }
        return layer
    }
    
    private func createNumberLayer() -> SymbolLayer {
        var layer = SymbolLayer(id: ItemId.count, source: ItemId.source)
        layer.textField = .expression(Exp(.get) { "point_count" })
        layer.textSize = .constant(12)
        layer.filter = Exp(.has) { "point_count" }
        return layer
    }
}
