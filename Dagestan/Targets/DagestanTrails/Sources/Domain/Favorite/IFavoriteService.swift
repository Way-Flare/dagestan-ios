//
//  IFavoriteService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 31.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

protocol IFavoriteService {
    func setFavorite(by id: Int, fromPlace: Bool) async throws -> Bool
}
