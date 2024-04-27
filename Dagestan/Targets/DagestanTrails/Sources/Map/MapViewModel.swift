import DagestanKit
import MapKit
import SwiftUI
@_spi(Experimental)
import MapboxMaps

final class MapViewModel: ObservableObject {
    @Published var viewport: Viewport = .styleDefault
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var isShowingDetailView = false

    let service: IPlacesService
    private var task: Task<Void, Error>?

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    init(service: IPlacesService) {
        self.service = service
        self.viewport = .styleDefault

        loadPlaces()
    }

    deinit {
        task?.cancel()
    }

    /// Устанвливает с анимацией viewPort с новыми координатами и зумом
    /// - Parameters:
    ///   - coordinate: Координаты
    ///   - zoomLevel: Уровень зума
    func setupViewport(coordinate: CLLocationCoordinate2D, zoomLevel: CGFloat) {
        withViewportAnimation(.fly) {
            viewport = .camera(center: coordinate, zoom: zoomLevel)
        }
    }

    private func loadPlaces() {
        Task {
            do {
                let places = try await service.getAllPlaces()
                await MainActor.run { [weak self] in
                    self?.places = places
                }
            } catch {
                print("Failed to load landmarks: \(error.localizedDescription)")
            }
        }
    }

    /// Выбирает место на основе переданного признака.
    /// - Parameter feature: Признак, который содержит свойства, необходимые для идентификации места.
    func selectPlace(by feature: Feature) {
        guard let id = (feature.properties?["id"] as? Turf.JSONValue)?.intValue,
              let selected = places.first(where: { $0.id == id }) else { return }

        withAnimation {
            selectedPlace = selected
            isShowingDetailView = true
        }
    }
}

// MARK: - Adapters

extension MapViewModel {
    /// Конвертирует модели Place в GeoJson для работы с MapBox
    /// - Returns: Data?
    func placesAsGeoJSON() -> Data? {
        let features = places.map { place -> [String: Any] in
            let geometry: [String: Any] = [
                "type": "Point",
                "coordinates": [place.coordinate.longitude, place.coordinate.latitude]
            ]
            let properties: [String: Any?] = [
                "id": place.id,
                "name": place.name,
                "description": place.shortDescription
            ]

            return [
                "type": "Feature",
                "geometry": geometry,
                "properties": properties
            ]
        }

        let geoJSON: [String: Any] = [
            "type": "FeatureCollection",
            "features": features
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: geoJSON)
            return jsonData
        } catch {
            print("Error serializing geoJSON: \(error)")
            return nil
        }
    }
}
