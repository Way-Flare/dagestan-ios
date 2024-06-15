//
//  FavoriteSection.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 15.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

enum FavoriteSection: String, CaseIterable, CustomStringConvertible {
    case places = "Места"
    case routes = "Маршруты"
    
    var description: String {
        return self.rawValue
    }
}
