import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Модель данных маршрута
struct Route {
    let startLocation: Location
    let endLocation: Location
    let route: MKRoute // Маршрут, предоставляемый MapKit
}
