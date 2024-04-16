//
//  PlacesService.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import DagestanKit

protocol PlacesServiceProtocol {
    func getAllPlaces() async throws -> [Place]
}

final class PlacesService: PlacesServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getAllPlaces() async throws -> [Place] {
        let endpoint = PlacesEndpoint.allPlaces
        
        do {
            let places = try await networkService.execute(
                endpoint,
                expecting: [Place].self
            )
            
            return places
        } catch {
            throw error
        }
    }
    
}
