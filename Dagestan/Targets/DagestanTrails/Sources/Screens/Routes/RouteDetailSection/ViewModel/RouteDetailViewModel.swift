//
//  RouteDetailViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation
import AppMetricaCore

protocol IRouteDetailViewModel: ObservableObject {
    var state: LoadingState<RouteDetail> { get }
    var routeCoordinates: [CLLocationCoordinate2D] { get }
    var service: IRouteService { get }
    var isBackdropVisible: Bool { get set }
    var routeFeedbacks: LoadingState<PlaceFeedbackList> { get }
    var shareUrl: URL? { get }
    /// Массив включающих всех юзеров кроме самого юзера
    var userFeedbacks: [PlaceFeedback] { get }

    func loadRouteDetail()
    func loadRouteFeedbacks()
    func calculateCenterAndApproximateZoom() -> (center: CLLocationCoordinate2D, zoom: Double)
}

final class RouteDetailViewModel: IRouteDetailViewModel {
    let service: IRouteService
    let shareUrl: URL?
    
    private let id: Int

    @Published var state: LoadingState<RouteDetail> = .idle
    @Published var isBackdropVisible = false
    @Published var routeFeedbacks: LoadingState<PlaceFeedbackList> = .idle

    var routeCoordinates: [CLLocationCoordinate2D] {
        [
            .init(latitude: 42.9833, longitude: 47.5046),
            .init(latitude: 41.1167, longitude: 45.1936),
            .init(latitude: 42.1167, longitude: 48.1936),
        ]
    }

    var userFeedbacks: [PlaceFeedback] {
        guard let feedbacks = routeFeedbacks.data?.results, !feedbacks.isEmpty else {
            return []
        }
        if feedbacks.first!.user.username == UserDefaults.standard.string(forKey: "username") {
            return Array(feedbacks.dropFirst())
        }
        return feedbacks
    }

    init(service: IRouteService, id: Int) {
        self.service = service
        self.id = id
        self.shareUrl = URL(string: "https://dagestan-trails.ru/route/\(id)")
    }

    @MainActor
    func loadRouteDetail() {
        state = .loading
        Task {
            do {
                let route = try await service.getRoute(id: id)
                state = .loaded(route)
                let params: [AnyHashable : Any] = ["routeId": "\(route.id)", "routeName": "\(route.title)"]
                AppMetrica.reportEvent(name: "Открыл детальную страницу маршрута", parameters: params, onFailure: { (error) in
                    print("DID FAIL REPORT EVENT: %@", "Блин")
                    print("REPORT ERROR: %@", error.localizedDescription)
                })
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func loadRouteFeedbacks() {
        routeFeedbacks = .loading

        Task {
            do {
                let parameters = PlaceFeedbackParametersDTO(id: id, pageSize: nil, pages: nil)
                let feedbacks = try await service.getRouteFeedbacks(parameters: parameters)
                routeFeedbacks = .loaded(feedbacks)
            } catch {
                routeFeedbacks = .failed(error.localizedDescription)
                print("Failed to load place: \(error.localizedDescription)")
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
