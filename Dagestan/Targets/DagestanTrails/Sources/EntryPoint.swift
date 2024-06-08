import SwiftUI
import DagestanKit
import DTDesignSystem

@main
struct EntryPoint: App {
    private let networkService = DTNetworkService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(networkService: networkService)
        }
    }
}

struct ContentView: View {
    let placesService = PlacesService(networkService: DTNetworkService())
    @State private var selectedTab: TabItem = .places // начальный выбор
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
                .tint(WFColor.accentPrimary)
                .onAppear {
                    setupTabBar()
                }
        }
    }
    
    private var contentView: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tabItemView(for: tab)
                    .tabItem {
                        VStack {
                            Text(NSLocalizedString(tab.title, comment: ""))
                            imageForTab(tab: tab)
                        }
                    }
            }
        }
    }
}

private extension ContentView {
    func imageForTab(tab: TabItem) -> SwiftUI.Image {
        let isSelected = (tab == selectedTab)
        let image = isSelected ? tab.selectedIcon : tab.icon
        return image
    }
    
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @ViewBuilder
    func tabItemView(for item: TabItem) -> some View {
        switch item {
            case .places: MapUIBox(viewModel: mapViewModel)
            case .dagestankit: MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
            default: Text(item.title)
        }
    }
}
