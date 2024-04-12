//
//  PlacesDataService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 12.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

protocol PlacesDataServiceProtocol {
    func fetchPlaces() async -> Result<PlacesResponse, RequestError>
}

final class PlacesDataService: Request, PlacesDataServiceProtocol {
    static let placesDataService = PlacesDataService()
    
    func fetchPlaces() async -> Result<PlacesResponse, RequestError> {
        return await sendRequest(endpoint: PlacesEndpoint.places, responseModel: PlacesResponse.self)
    }
}
