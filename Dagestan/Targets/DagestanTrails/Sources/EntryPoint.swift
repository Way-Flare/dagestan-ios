import SwiftUI
import DagestanKit

@main
struct EntryPoint: App {
    private let networkService = DTNetworkService()
    private let timerViewModel = TimerViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(networkService: networkService)
                .environmentObject(timerViewModel)
        }
    }
}

struct ContentView: View {
    let placesService = PlacesService(networkService: DTNetworkService())
    @StateObject private var mapViewModel: MapViewModel
    
    // сделать бы норм инжект)
    init(networkService: NetworkServiceProtocol) {
        let placesService = PlacesService(networkService: networkService)
        _mapViewModel = StateObject(wrappedValue: MapViewModel(service: placesService))
    }
    
    var body: some View {
        let _ = Self._printChanges()
        
        NavigationStack {
            contentView
                .tint(DagestanKitAsset.iconAccent.swiftUIColor)
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
                        VStack(spacing: 4) {
                            tab.icon
                            Text(tab.title)
                        }
                        .font(DagestanKitFontFamily.Manrope.regular.swiftUIFont(size: 12))
                    }
            }
        }
    }
}

private extension ContentView {
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = DagestanKitAsset.bgSurface1.color
        
        appearance.stackedLayoutAppearance.normal.iconColor = DagestanKitAsset.fgDefault.color
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: DagestanKitAsset.fgDefault.color]
                
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @ViewBuilder
    func tabItemView(for item: TabItem) -> some View {
        switch item {
            case .map: MapView(viewModel: mapViewModel)
            case .profile: AuthorizationView()
            case .favorite: FavoritesView()
            case .dagestankit: MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
            default: Text(item.title)
        }
    }
}
