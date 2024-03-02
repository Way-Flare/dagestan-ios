import MapKit
import DagestanKit

struct MapState: MVIStatable {
    var currentLocation: CLLocationCoordinate2D
    var locations: [Location] // Метки на карте
    var selectedRoute: Route? // Выбранный маршрут

    static func == (lhs: MapState, rhs: MapState) -> Bool {
        return lhs.currentLocation == rhs.currentLocation &&
        lhs.locations == rhs.locations &&
        lhs.selectedRoute == rhs.selectedRoute
    }
}

// Модель местоположения
struct Location: Identifiable, Equatable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Модель данных маршрута
struct Route {
    let startLocation: Location
    let endLocation: Location
    let route: MKRoute // Маршрут, предоставляемый MapKit
}

// MARK: - CLLocationCoordinate2D


extension CLLocationCoordinate2D: Equatable {
    public static func == (
        lhs: CLLocationCoordinate2D,
        rhs: CLLocationCoordinate2D
    ) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Route: Equatable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.startLocation == rhs.startLocation &&
        lhs.endLocation == rhs.endLocation
    }
}
