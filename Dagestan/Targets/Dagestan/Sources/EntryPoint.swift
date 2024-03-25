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
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var mapViewModel = MapViewModel()

    var body: some View {
        _ = Self._printChanges()

        NavigationStack {
            TabView {
                MapUI(viewModel: mapViewModel)
                    .tabItem { Label("tab.item.map", systemImage: "map") }

                Text("CollectionsView")
                    .tabItem { Label("tab.item.favorites", systemImage: "star.fill") }

                AuthenticationUI(viewModel: authViewModel)
                    .tabItem { Label("tab.item.profile", systemImage: "person.fill") }
            }
            .tint(.red)
        }
        .toolbarBackground(.indigo, for: .tabBar)

    }
}

#Preview {
    ContentView()
}
