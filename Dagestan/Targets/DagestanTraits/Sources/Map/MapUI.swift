import SwiftUI
import MapKit
import DagestanKit

struct MapUI: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.landmarks) { landmark in
            MapAnnotation(coordinate: landmark.coordinate) {
                makeMapAnnotation(text: landmark.name)
                    .onTapGesture {
                        viewModel.setMapLocation(location: landmark)
                    }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - UI Elements
private extension MapUI {
    func makeMapAnnotation(text: String) -> some View {
        ZStack {
            VStack(spacing: Grid.pt0) {
                RoundedRectangle(cornerRadius: Grid.pt10)
                    .fill(.thinMaterial)
                    .frame(minHeight: Grid.pt46)
                Triangle()
                    .fill(.thinMaterial)
                    .frame(width: Grid.pt20, height: Grid.pt10)
            }
            HStack(spacing: Grid.pt8) {
                Image(systemName: "mountain.2.circle")
                    .foregroundColor(.green)
                    .imageScale(.large)
                
                VStack(alignment: .leading, spacing: Grid.pt0) {
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
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}
