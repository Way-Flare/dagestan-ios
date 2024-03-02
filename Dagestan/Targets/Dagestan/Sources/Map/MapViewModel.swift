import DagestanKit
import MapKit

final class MapViewModel: BaseMVIViewModel<MapState> {
    override func createInitialState() -> MapState {
        return MapState(
            currentLocation: mahachkalaCoordinates,
            locations: [
                sulakCanyon,
                bazardyuzyuMountain,
                kezenoyamLake
            ]
        )
    }
}

// MARK: - MapInteractionable
extension MapViewModel: MapInteractionable {
    func didTapOnPlace() {
        print("User tap on place :)")
    }
}

let mahachkalaCoordinates = CLLocationCoordinate2D(latitude: 42.98, longitude: 47.50)

// MARK: - Mocked Locations

private let sulakCanyon = Location(
    id: UUID(),
    name: "Сулакский каньон",
    coordinate: CLLocationCoordinate2D(latitude: 43.021772, longitude: 46.826379)
)

private let bazardyuzyuMountain = Location(
    id: UUID(),
    name: "Гора Базардюзю",
    coordinate: CLLocationCoordinate2D(latitude: 42.4464, longitude: 46.7933)
)

private let kezenoyamLake = Location(
    id: UUID(),
    name: "Озеро Кезеной-ам",
    coordinate: CLLocationCoordinate2D(latitude: 42.9833, longitude: 46.2667)
)
