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
    
    var body: some View {
        
        NavigationStack {
            TabView {
                Text("MapView")
                    .tabItem { Label("tab.item.map", systemImage: "map") }
                
                Text("CollectionsView")
                    .tabItem { Label("tab.item.collections", systemImage: "star.fill") }
                
                 Text("ProfileView")
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
