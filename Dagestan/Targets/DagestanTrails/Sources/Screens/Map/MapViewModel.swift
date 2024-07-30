import CoreKit
import MapKit
import SwiftUI
@_spi(Experimental)
import MapboxMaps

protocol IMapViewModel: ObservableObject {
    var viewport: Viewport { get set }
    var places: [Place] { get set }
    var filteredPlaces: [Place] { get }
    var selectedPlace: Place? { get set }
    var isPlaceViewVisible: Bool { get set }
    var isShowAlert: Bool { get set }
    var isLoading: Bool { get set }
    var selectedTags: Set<TagPlace> { get set }
    var service: IPlacesService { get }

    func setupViewport(coordinate: CLLocationCoordinate2D, zoomLevel: CGFloat)
    func loadPlaces()
    func selectPlace(by feature: Feature)
    func selectPlace(by id: Int)
    func updateFilteredPlaces()
    func toggleTag(_ tag: TagPlace)
    func moveToDagestan()
    func placesAsGeoJSON() -> Data?
}

final class MapViewModel: IMapViewModel {
    @Published var viewport: Viewport = .camera(center: Location.makhachkala, zoom: 5.5)
    @Published var places: [Place] = [] {
        didSet {
            filteredPlaces = places
        }
    }

    @Published var isShowAlert: Bool = false
    @Published var isLoading: Bool = false
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

    func loadPlaces() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            isShowAlert = false
            isLoading = true

            do {
                let places = try await service.getAllPlaces()
                self.places = places
                updateFilteredPlaces()
                isLoading = false
            } catch {
                print("Failed to load landmarks: \(error.localizedDescription)")
                isShowAlert = true
                isLoading = false
            }
        }
    }

    /// Выбирает место на основе переданного признака.
    /// - Parameter feature: Признак, который содержит свойства, необходимые для идентификации места.
    func selectPlace(by feature: Feature) {
        guard let id = (feature.properties?["id"] as? Turf.JSONValue)?.intValue,
              let selected = filteredPlaces.first(where: { $0.id == id }) else { return }

        selectedPlace = selected
        withViewportAnimation(.easeIn(duration: 0.3)) {
            viewport = .camera(center: selectedPlace?.coordinate)
        }
    }

    /// Выбирает место на основе переданного id.
    /// - Parameter id: Параметр необходимые для идентификации места.
    func selectPlace(by id: Int) {
        withAnimation {
            selectedPlace = filteredPlaces.first { $0.id == id }
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
                "place_name": place.name,
                "description": place.shortDescription,
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

extension MapViewModel {
    enum Location {
        static let makhachkala = CLLocationCoordinate2D(latitude: 42.9824, longitude: 47.5049)
    }
}
