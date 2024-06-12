import SwiftUI
import CoreKit
import DesignSystem

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
                .tint(WFColor.iconAccent)
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
                        VStack(spacing: Grid.pt4) {
                            tab.icon
                            Text(NSLocalizedString(tab.title, comment: ""))
                        }
                        .font(.manropeRegular(size: Grid.pt12))
                    }
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
            case .places: MapView(viewModel: mapViewModel)
            case .profile: AuthorizationView()
            case .favorite: FavoritesView()
            case .designSystem: MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
            default: Text(item.title)
        }
    }
}
