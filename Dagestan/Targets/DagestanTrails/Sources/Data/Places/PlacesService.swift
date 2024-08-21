//
//  PlacesService.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//

import CoreKit
import Foundation

/// Сервис для работы с точками/местами
final class PlacesService: IPlacesService {
    private let networkService: INetworkService
    
    init(networkService: INetworkService) {
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
    
    func setFavorite(by id: Int) async throws -> Bool {
        let endpoint = PlacesEndpoint.favorite(id: id)
        
        do {
            let statusCode = try await networkService.execute(endpoint)
            if statusCode == 201 {
                return true
            } else if statusCode == 204 {
                return false
            } else {
                throw RequestError.unknown
            }
        } catch {
            throw error
        }
    }
        
    func getPlaceFeedbacks(parameters: PlaceFeedbackParametersDTO) async throws -> PlaceFeedbackList {
        let endpoint = PlacesEndpoint.placeFeedbacks(parameters: parameters)

        do {
            let placeFeedbackList = try await networkService.execute(endpoint, expecting: PlaceFeedbackListDTO.self)
            return placeFeedbackList.asDomain()
        } catch {
            throw error
        }
    }
    
    func getPromocode(by id: Int) async throws -> [Promocode] {
        let endpoint = PlacesEndpoint.promocode(id: id)

        do {
            let promocode = try await networkService.execute(endpoint, expecting: [PromocodeDTO].self)
            return promocode.map { $0.asDomain() }
        } catch {
            throw error
        }
    }
}
