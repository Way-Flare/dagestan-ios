import CoreKit
import DesignSystem
import SwiftUI

@main
struct EntryPoint: App {
    private let networkService = DTNetworkService()
    private let timerViewModel = TimerViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(networkService: networkService)
                .environmentObject(timerViewModel)
                .environment(\.colorScheme, .light)
        }
    }
}

struct ContentView: View {
    @StateObject private var mapViewModel: MapViewModel
    @StateObject private var routeViewModel: RouteListViewModel
    private let authService: AuthService

    // сделать бы норм инжект)
    init(networkService: NetworkServiceProtocol) {
        FontManager.registerFonts()
        let placesService = PlacesService(networkService: networkService)
        let routeService = RouteService(networkService: networkService)
        let authService = AuthService(networkService: networkService)

        self._mapViewModel = StateObject(wrappedValue: MapViewModel(service: placesService))
        self._routeViewModel = StateObject(wrappedValue: RouteListViewModel(service: routeService))
        self.authService = authService
    }

    var body: some View {
        let _ = Self._printChanges()

        contentView
            .tint(WFColor.iconAccent)
            .onAppear {
                setupTabBar()
            }
    }

    private var contentView: some View {
        TabView {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tabItemView(for: tab)
                    .tabItem {
                        VStack(spacing: Grid.pt4) {
                            tab.icon
                            Text(NSLocalizedString(tab.title, comment: ""))
                        }
                        .font(.manropeRegular(size: Grid.pt12))
                    }
                    .tag(tab.rawValue)
            }
        }
    }
}

private extension ContentView {
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(WFColor.surfacePrimary)

        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(WFColor.foregroundPrimary)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(WFColor.foregroundPrimary)
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    @ViewBuilder
    func tabItemView(for item: TabItem) -> some View {
        switch item {
            case .places: MapView(viewModel: mapViewModel, routeService: routeViewModel.service)
            case .profile: ProfileContainerView(authService: authService)
            case .favorite: FavoriteListView()
            case .routes:
                RouteListView(viewModel: routeViewModel, placeService: mapViewModel.service) {
                    print("ROUTE FAVORITE")
                }
        }
    }
}
