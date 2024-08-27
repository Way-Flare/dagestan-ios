import CoreKit
import DesignSystem
import SwiftUI
import AppMetricaCore

@main
struct EntryPoint: App {
    private let networkService = DTNetworkService()
    private let timerViewModel = TimerViewModel()
    private let configuration = AppMetricaConfiguration(apiKey: "ca041ea3-c21d-4c43-84df-0ac1ab745f81")

    init() {
        AppMetrica.activate(with: configuration!)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(networkService: networkService)
                .environmentObject(timerViewModel)
        }
    }
}

struct ContentView: View {
    @StateObject private var mapViewModel: MapViewModel
    @StateObject private var routeViewModel: RouteListViewModel
    @StateObject private var favoriteViewModel: FavoriteListViewModel
    @StateObject var locationsModel = StandardStyleLocationsModel()
    private let authService: AuthService
    private let favoriteService: FavoriteService
    private let feedbackService: FeedbackService

    // сделать бы норм инжект)
    init(networkService: INetworkService) {
        FontManager.registerFonts()
        let placesService = PlacesService(networkService: networkService)
        let routeService = RouteService(networkService: networkService)
        let authService = AuthService(networkService: networkService)
        let favoriteService = FavoriteService(networkService: networkService)
        let feedbackService = FeedbackService(networkService: networkService)

        self._mapViewModel = StateObject(wrappedValue: MapViewModel(placeService: placesService, favoriteService: favoriteService))
        self._routeViewModel = StateObject(
            wrappedValue: RouteListViewModel(
                routeService: routeService,
                favoriteService: favoriteService
            )
        )
        self._favoriteViewModel = StateObject(
            wrappedValue: FavoriteListViewModel(
                placeService: placesService,
                routeService: routeService,
                favoriteService: favoriteService
            )
        )
        self.authService = authService
        self.favoriteService = favoriteService
        self.feedbackService = feedbackService
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
            case .places: MapView(viewModel: mapViewModel, routeService: routeViewModel.routeService)
                    .environmentObject(locationsModel)
            case .profile: ProfileContainerView(authService: authService, feedbackService: feedbackService)
            case .favorite: FavoriteListView(viewModel: favoriteViewModel)
            case .routes: RouteListView(viewModel: routeViewModel, placeService: mapViewModel.placeService)
        }
    }
}
