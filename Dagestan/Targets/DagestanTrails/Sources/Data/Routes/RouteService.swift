//
//  RouteService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

public final class RouteService: IRouteService {
    let networkService: INetworkService
    
    public init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    public func getAllRoutes() async throws -> [Route] {
        let endpoint = RouteEndpoint.allRoutes
        
        do {
            let routes = try await networkService.execute(
                endpoint,
                expecting: [RouteDTO].self
            )
            
            return routes.map { $0.asDomain() }
        } catch {
            throw error
        }
    }
    
    public func getRoute(id: Int) async throws -> RouteDetail {
        let endpoint = RouteEndpoint.route(id: id)
        
        do {
            let route = try await networkService.execute(
                endpoint,
                expecting: RouteDetailDTO.self
            )
            
            return route.asDomain()
        } catch {
            throw error
        }
    }
    
    public func getRouteFeedbacks(parameters: PlaceFeedbackParametersDTO) async throws -> PlaceFeedbackList {
        let endpoint = RouteEndpoint.routeFeedbacks(parameters: parameters)

        do {
            let routeFeedbackList = try await networkService.execute(endpoint, expecting: PlaceFeedbackListDTO.self)

            return routeFeedbackList.asDomain()
        } catch {
            throw error
        }
    }
}
