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
        NavigationStack {
            contentView
                .tint(.red)
                .onAppear {
                    setupTabBar()
                }
        }
    }
    
    private var contentView: some View {
        TabView {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tabItemView(for: tab)
                    .tabItem {
                        Label(
                            NSLocalizedString(tab.title, comment: ""),
                            systemImage: tab.icon
                        )
                    }
            }
        }
    }
}

private extension ContentView {
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @ViewBuilder
    func tabItemView(for item: TabItem) -> some View {
        switch item {
        case .map: MapUIBox()
        case .favorite: Text("Favorite")
        case .profile: Text("Profile")
        case .route: Text("Route")
        }
    }
}
