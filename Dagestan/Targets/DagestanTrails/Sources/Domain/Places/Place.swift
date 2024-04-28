//
//  Place.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation
import DagestanKit

public struct Place: Identifiable {
    public let id: Int
    public let coordinate: CLLocationCoordinate2D
    public let name: String
    public let shortDescription: String?
    public let image: URL?
    public let rating: Double?
    public let workTime: String?
    public let tags: [TagPlace]?
    public let feedbackCount: Int?
}

extension Place: Equatable {
    public static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id && lhs.coordinate.latitude == rhs.coordinate.latitude &&
               lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.name == rhs.name
    }
}
