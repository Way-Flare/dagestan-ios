import MapKit
import SwiftUI

final class MapViewModel: ObservableObject {

    private var task: Task<Void, Error>?

    @Published var landmarks: [Location] = []

    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }

    // Регион для центрирования карты
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)


    init() {
        self.mapLocation = Location(name: "Сулакский каньон", coordinate: CLLocationCoordinate2D(latitude: 43.021772, longitude: 46.826379))

        task?.cancel()
        task = Task {
            let landmarks = await loadLandmarks()
            await MainActor.run {
                self.landmarks = landmarks
                self.mapLocation = landmarks.first!
            }
        }
    }

    deinit {
        task?.cancel()
    }

    private func loadLandmarks() async -> [Location] {
        // Симуляция задержки сетевого запроса
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Задержка в 1 секунды

        // После "задержки" обновляем данные о достопримечательностях
        let loadedLandmarks = [
            Location(name: "Гора Базардюзю", coordinate: CLLocationCoordinate2D(latitude: 42.4464, longitude: 46.7933)),
            Location(name: "Сулакский каньон", coordinate: CLLocationCoordinate2D(latitude: 43.021772, longitude: 46.826379)),
            Location(name: "Дербентская крепость", coordinate: CLLocationCoordinate2D(latitude: 42.0402, longitude: 48.2908))
        ]

        return loadedLandmarks
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(
                center: location.coordinate,
                span: mapSpan
            )
        }
    }

    func setMapLocation(location: Location) {
        mapLocation = location
    }
}

let mahachkalaCoordinates = CLLocationCoordinate2D(latitude: 42.98, longitude: 47.50)
