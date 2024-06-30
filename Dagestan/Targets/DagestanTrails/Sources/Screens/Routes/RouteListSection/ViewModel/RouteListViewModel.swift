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
    var routes: [Route] { get }
    var service: IRouteService { get }
    
    func fetchRoutes() async
}

class RouteListViewModel: IRouteListViewModel {
    @Published var path = NavigationPath()
    @Published var routes: [Route] = []

    let service: IRouteService

    init(service: IRouteService) {
        self.service = service
    }

    @MainActor
    func fetchRoutes() async {
        do {
            let fetchedRoutes = try await service.getAllRoutes()
            self.routes = fetchedRoutes
        } catch {
            print("Ошибка при получении данных: \(error)")
        }
    }
}
