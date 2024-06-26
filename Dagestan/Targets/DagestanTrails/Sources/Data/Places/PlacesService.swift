//
//  PlacesService.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//

import Foundation
import CoreKit

/// Сервис для работы с точками/местами
final class PlacesService: IPlacesService {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getAllPlaces() async throws -> [Place] {
        let endpoint = PlacesEndpoint.allPlaces
        
        do {
            let places = try await networkService.execute(
                endpoint,
                expecting: [PlaceDTO].self
            )
            
            return places.map { $0.asDomain() }
        } catch {
            throw error
        }
    }
    
    func getPlace(id: Int) async throws -> PlaceDetail {
        let endpoint = PlacesEndpoint.place(id: id)
        
        do {
            let place = try await networkService.execute(
                endpoint,
                expecting: PlaceDetailDTO.self
            )
            
            return place.asDomain()
        } catch {
            throw error
        }
    }
}
