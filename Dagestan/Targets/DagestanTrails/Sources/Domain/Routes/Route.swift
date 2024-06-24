//
//  Route.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct Route {
    let id: Int
    let title: String
    let images: [URL?]
    let shortDescription: String?
    let distance: Double
    let travelTime: String
    let feedbackCount: Int
    let rating: Double
}
