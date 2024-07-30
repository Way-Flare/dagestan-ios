//
//  RouteListViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

protocol IRouteListViewModel: ObservableObject {
    var path: NavigationPath { get set }
    var state: LoadingState<[Route]> { get }
    var service: IRouteService { get }
    
    func fetchRoutes() async
}

class RouteListViewModel: IRouteListViewModel {
    @Published var path = NavigationPath()
    @Published var state: LoadingState<[Route]> = .idle

    let service: IRouteService

    init(service: IRouteService) {
        self.service = service
    }

    @MainActor
    func fetchRoutes() async {
        state = .loading
        
        do {
            let fetchedRoutes = try await service.getAllRoutes()
            state = .loaded(fetchedRoutes)
        } catch {
            state = .failed(error.localizedDescription)
            print("Ошибка при получении данных: \(error)")
        }
    }
}
