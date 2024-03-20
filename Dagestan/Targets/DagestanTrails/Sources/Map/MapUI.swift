import SwiftUI
import MapKit
import DagestanKit

struct MapUI: View {
    @ObservedObject private var viewModel: MapViewModel

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {

            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    makeMapAnnotation(text: landmark.name)
                        .onTapGesture {
                            viewModel.setMapLocation(location: landmark)
                        }
                }
            }

        }
        .ignoresSafeArea()
    }

}

// MARK: - UI Elements
private extension MapUI {

    func makeMapAnnotation(text: String) -> some View {
        ZStack() {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10) // Задаем радиус скругления
                    .fill(.thinMaterial) // Указываем белый цвет фона
                    .frame(minHeight: 46) // Устанавливаем размеры прямоугольника
                Triangle()
                    .fill(.thinMaterial)
                    .frame(width: 20, height: 10)
            }
            HStack(spacing: 8) {
                Image(systemName: "mountain.2.circle")
                    .foregroundColor(.green)
                    .imageScale(.large)

                VStack(alignment: .leading, spacing: 0) {
                    Text(text)
                        .foregroundStyle(.primary)
                        .bold()
                    Text("Смотровая")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)

                }
            }
            .offset(x: -15, y: -5)
        }

    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY)) // Вершина внизу
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // Левая верхняя точка
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Правая верхняя точка
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) // Возвращаемся к вершине

        return path
    }
}
