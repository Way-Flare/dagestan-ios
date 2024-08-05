//
//  FavoriteService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 31.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import CoreKit

final class FavoriteService: IFavoriteService {
    let networkService: INetworkService

    init(networkService: INetworkService) {
        self.networkService = networkService
    }

    func setFavorite(by id: Int, fromPlace: Bool) async throws -> Bool {
        let endpoint = FavoriteEndpoint.favorite(id: id, fromPlace: fromPlace)

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
}
