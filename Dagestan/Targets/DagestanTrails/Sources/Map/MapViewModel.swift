import DagestanKit
import MapKit
import SwiftUI
@_spi(Experimental)
import MapboxMaps

final class MapViewModel: ObservableObject {
    @Published var viewport: Viewport = .styleDefault
    @Published var landmarks: [Place] = []

    private let service: IPlacesService
    private var task: Task<Void, Error>?

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    init(service: IPlacesService) {
        self.service = service
        self.viewport = .styleDefault

        loadLandmarks()
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

    private func loadLandmarks() {
        Task {
            do {
                let places = try await service.getAllPlaces()
                await MainActor.run { [weak self] in
                    self?.landmarks = places
                }
            } catch {
                print("Failed to load landmarks: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Adapters

extension MapViewModel {
    /// Конвертирует модели Place в GeoJson для работы с MapBox
    /// - Returns: Data?
    func landmarksAsGeoJSON() -> Data? {
        let features = landmarks.map { landmark -> [String: Any] in
            let geometry: [String: Any] = [
                "type": "Point",
                "coordinates": [landmark.coordinate.longitude, landmark.coordinate.latitude]
            ]
            let properties: [String: Any?] = [
                "id": landmark.id,
                "name": landmark.name,
                "description": landmark.shortDescription
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
