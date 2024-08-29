import CoreKit
import MapKit
import SwiftUI
import MapboxMaps

/// Протокол вью модели для работы с картой
protocol IMapViewModel: ObservableObject {
    /// Viewport - структура mapbox с данными о камере
    var viewport: Viewport { get set }
    /// Список всехт мест
    var places: [Place] { get set }
    /// Список отфильтрованных мест
    var filteredPlaces: [Place] { get }
    /// Выбранное место
    var selectedPlace: Place? { get set }
    /// Видна ли карточка места
    var isPlaceViewVisible: Bool { get set }
    /// Отображать ли алерт с ошибкой
    var isShowAlert: Bool { get set }
    /// Идет ли сейчас загрузка мест
    var isLoading: Bool { get set }
    /// Выбранные теги/фильтры
    var selectedTags: Set<TagPlace> { get set }
    /// Сервис для работы с местами
    var placeService: IPlacesService { get }
    /// Сервис для работы с избранными
    var favoriteService: IFavoriteService { get }
    /// Состояние загрузки добавления/удаления места из избранного
    var favoriteState: LoadingState<Bool> { get set }
    /// Отображать ли ошибку связанную с избранными. Например, если пользователь не авторизован
    var showFavoriteAlert: Bool { get set }
    /// Открыть ли экран с поиском мест
    var searchOpen: Bool { get set }
    /// Список тегов/фильтров
    var tags: [TagPlace] { get set }

    /// Устанвливает с анимацией viewPort с новыми координатами и зумом
    /// - Parameters:
    ///   - coordinate: Координаты
    ///   - zoomLevel: Уровень зума
    func setupViewport(coordinate: CLLocationCoordinate2D, zoomLevel: CGFloat)
    /// Загрузить все места
    func loadPlaces()
    /// Выбирает место на основе переданного признака. (Нажали на точку, на карте)
    /// - Parameter feature: Признак, который содержит свойства, необходимые для идентификации места.
    func selectPlace(by feature: Feature)
    /// Выбирает место на основе переданного id. (Нажали на точку, на карте)
    /// - Parameter id: Параметр необходимые для идентификации места.
    func selectPlace(by id: Int)
    /// Обновить список отфильтрованных мест. Нужно при выборе какого то тэга
    func updateFilteredPlaces()
    /// Вкл/выкл фильтр/тэг
    func toggleTag(_ tag: TagPlace)
    /// Установить камеру на начальную позицию - Дагестан
    func moveToDagestan()
    /// Получить точки в GeoJson
    func placesAsGeoJSON() -> Data?
    /// Добавить/удалить из избранного место по id
    func setFavorite(by id: Int)
}

/// Вьюмодель для работы с картой
final class MapViewModel: IMapViewModel {
    @Published var viewport: Viewport = .camera(center: Location.makhachkala, zoom: 5.5)
    @Published var tags: [TagPlace] = []
    @Published var places: [Place] = [] {
        didSet {
            filteredPlaces = places
        }
    }

    @Published var isShowAlert = false
    @Published var searchOpen = false
    @Published var showFavoriteAlert = false
    @Published var isLoading = false
    @Published var filteredPlaces: [Place] = []
    @Published var selectedPlace: Place?
    @Published var isPlaceViewVisible = true
    @Published var selectedTags: Set<TagPlace> = []
    @Published var favoriteState: LoadingState<Bool> = .idle

    // MARK: - Init

    /// Сервис для работы с местами/точками
    let placeService: IPlacesService
    /// Сервис для работы с избраными
    let favoriteService: IFavoriteService

    /// Инициализатор
    /// - Parameter placeService: Сервис для работы с местами/точками
    /// - Parameter favoriteService: Сервис для работы с избраными
    init(placeService: IPlacesService, favoriteService: IFavoriteService) {
        self.placeService = placeService
        self.favoriteService = favoriteService

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoriteUpdate(_:)),
            name: .didUpdateFavorites,
            object: nil
        )
        loadPlaces()
    }

}

// MARK: - Public methods of IMapViewModel

extension MapViewModel {
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
                let places = try await placeService.getAllPlaces()
                self.places = places
                for place in places {
                    if let tag = place.tags?.first, !self.tags.contains(tag) {
                        self.tags.append(tag)
                    }
                }
                updateFilteredPlaces()
                isLoading = false
            } catch {
                print("Failed to load landmarks: \(error.localizedDescription)")
                isShowAlert = true
                isLoading = false
            }
        }
    }

    func selectPlace(by feature: Feature) {
        guard let id = (feature.properties?["id"] as? Turf.JSONValue)?.intValue,
              let selected = filteredPlaces.first(where: { $0.id == id }) else { return }

        selectedPlace = selected
        withViewportAnimation(.easeIn(duration: 0.3)) {
            viewport = .camera(center: selectedPlace?.coordinate)
        }
    }

    func selectPlace(by id: Int) {
        withAnimation {
            selectedPlace = filteredPlaces.first { $0.id == id }
        }
    }

    func setFavorite(by id: Int) {
        favoriteState = .loading

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let status = try await favoriteService.setFavorite(by: id, fromPlace: true)
                self.updateFavoriteStatus(for: id, to: status)
                favoriteState = .loaded(status)
            } catch {
                self.showFavoriteAlert = true

                if let error = error as? RequestError {
                    favoriteState = .failed(error.message)
                } else {
                    favoriteState = .failed(error.localizedDescription)
                }
                print("Failed to set favorite: \(error.localizedDescription)")
            }
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
            viewport = .camera(center: dagestanCoordinates, zoom: 7.5)
        }
    }
}

// MARK: - Private methods

extension MapViewModel {

    private func updateFavoriteStatus(for id: Int, to status: Bool) {
        if let index = places.firstIndex(where: { $0.id == id }) {
            var updatedPlace = places[index]
            updatedPlace = updatedPlace.withFavoriteStatus(to: status)
            places[index] = updatedPlace

            if selectedPlace?.id == id {
                selectedPlace = updatedPlace
            }
        }
    }

    @objc
    private func handleFavoriteUpdate(_ notification: Notification) {
        guard let updater = notification.object as? FavoriteUpdater else { return }

        if updater.type == .places {
            updateFavoriteStatus(for: updater.id, to: updater.status)
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

extension MapViewModel {
    enum Location {
        static let makhachkala = CLLocationCoordinate2D(latitude: 42.9824, longitude: 47.5049)
    }
}
