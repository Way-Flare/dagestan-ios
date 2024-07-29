//
//  RouteDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation

protocol IRouteDetailViewModel: ObservableObject {
    var state: LoadingState<RouteDetail> { get }
    var routeCoordinates: [CLLocationCoordinate2D] { get }
    var service: IRouteService { get }
    var isBackdropVisible: Bool { get set }

    func loadRouteDetail()
    func calculateCenterAndApproximateZoom() -> (center: CLLocationCoordinate2D, zoom: Double)
}

final class RouteDetailViewModel: IRouteDetailViewModel {
    let service: IRouteService
    private let id: Int

    @Published var state: LoadingState<RouteDetail> = .idle
    @Published var isBackdropVisible = false

    var routeCoordinates: [CLLocationCoordinate2D] {
        [
            .init(latitude: 42.9833, longitude: 47.5046),
            .init(latitude: 41.1167, longitude: 45.1936),
            .init(latitude: 42.1167, longitude: 48.1936),
        ]
    }

    init(service: IRouteService, id: Int) {
        self.service = service
        self.id = id
    }

    @MainActor
    func loadRouteDetail() {
        state = .loading
        Task {
            do {
                let route = try await service.getRoute(id: id)
                state = .loaded(route)
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }

    func calculateCenterAndApproximateZoom() -> (center: CLLocationCoordinate2D, zoom: Double) {
        guard !routeCoordinates.isEmpty else { return (CLLocationCoordinate2D(), 0) }

        let latitudes = routeCoordinates.map { $0.latitude }
        let longitudes = routeCoordinates.map { $0.longitude }

        let latMin = latitudes.min() ?? 0
        let latMax = latitudes.max() ?? 0
        let longMin = longitudes.min() ?? 0
        let longMax = longitudes.max() ?? 0

        let centerLat = (latMin + latMax) / 2
        let centerLong = (longMin + longMax) / 2
        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong)

        let latDiff = latMax - latMin
        let longDiff = longMax - longMin
        let maxDiff = max(latDiff, longDiff)
        var zoom = 10.0

        if maxDiff < 0.01 {
            zoom = 11
        } else if maxDiff < 0.1 {
            zoom = 9.0
        } else if maxDiff < 1.0 {
            zoom = 7.0
        } else {
            zoom = 6.0
        }

        return (center, zoom)
    }
}
