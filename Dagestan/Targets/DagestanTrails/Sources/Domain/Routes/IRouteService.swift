//
//  IRouteService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public protocol IRouteService {
    func getAllRoutes() async throws -> [Route]
    func getRoute(id: Int) async throws -> RouteDetail
    func getRouteFeedbacks(parameters: PlaceFeedbackParametersDTO) async throws -> PlaceFeedbackList 
}
