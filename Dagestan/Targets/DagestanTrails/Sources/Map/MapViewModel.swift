import DagestanKit
import MapKit
import SwiftUI
@_spi(Experimental)
import MapboxMaps

final class MapViewModel: ObservableObject {
    @Published var viewport: Viewport = .styleDefault
    @Published var places: [Place] = [] {
        didSet {
            filteredPlaces = places
        }
    }

    @Published var filteredPlaces: [Place] = []
    @Published var selectedPlace: Place?
    @Published var isPlaceViewVisible = true
    @Published var selectedTags: Set<TagPlace> = []

    let service: IPlacesService
    private var task: Task<Void, Error>?

    /// Инициализатор
    /// - Parameter service: Сервис для работы с местами/точками
    init(service: IPlacesService) {
        self.service = service

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
        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let places = try await service.getAllPlaces()
                self.places = places
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
            isPlaceViewVisible = true
            selectedPlace = selected
        }
    }

    /// Выбирает место на основе переданного id.
    /// - Parameter id: Параметр необходимые для идентификации места.
    func selectPlace(by id: Int) {
        print(id)
        guard let selected = places.first(where: { $0.id == id }) else { return }

        withAnimation {
            isPlaceViewVisible = true
            selectedPlace = selected
        }
    }

    func updateFilteredPlaces() {
        if selectedTags.isEmpty {
            filteredPlaces = places
        } else {
            filteredPlaces = places.filter { place in
                !selectedTags.isDisjoint(with: place.tags ?? [])
            }
        }
        
        filteredPlaces.forEach { print($0.name) }
    }

    func toggleTag(_ tag: TagPlace) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
        updateFilteredPlaces()
    }
    
    func moveToDagestan() {
        let dagestanCoordinates = CLLocationCoordinate2D(latitude: 43.0000, longitude: 47.5000)

        withViewportAnimation(.fly) {
            viewport = .camera(center: dagestanCoordinates, zoom: 6.5)
        }
    }
}

// MARK: - Adapters

extension MapViewModel {
    /// Конвертирует модели Place в GeoJson для работы с MapBox
    /// - Returns: Data?
    func placesAsGeoJSON() -> Data? {
        let features = filteredPlaces.map { place -> [String: Any] in
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
