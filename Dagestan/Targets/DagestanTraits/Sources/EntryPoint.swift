import SwiftUI
import DagestanKit

@main
struct EntryPoint: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some View {
        let _ = Self._printChanges()
        
        NavigationStack {
            TabView {
                MapUI(viewModel: mapViewModel)
                    .tabItem {
                        Label(
                            NSLocalizedString( "tab.item.map", comment: ""),
                            systemImage: "map.fill"
                        )
                    }
                
                Text("CollectionsView")
                    .tabItem {
                        Label(
                            NSLocalizedString("tab.item.favorites", comment: ""),
                            systemImage: "star.fill"
                        )
                    }
            }
            .tint(.red)
        }
        .toolbarBackground(.indigo, for: .tabBar)

    }
}

#Preview {
    ContentView()
}
