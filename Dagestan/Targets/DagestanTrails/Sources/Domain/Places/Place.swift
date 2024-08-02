//
//  Place.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//

import CoreKit
import CoreLocation

public struct Place: Identifiable {
    public let id: Int
    public let coordinate: CLLocationCoordinate2D
    public let name: String
    public let shortDescription: String?
    public let images: [URL]
    public let rating: Double?
    public let workTime: String?
    public let tags: [TagPlace]?
    public let feedbackCount: Int?
    public let isFavorite: Bool

    public init(
        id: Int,
        coordinate: CLLocationCoordinate2D,
        name: String,
        shortDescription: String? = nil,
        images: [URL],
        rating: Double? = nil,
        workTime: String? = nil,
        tags: [TagPlace]? = nil,
        feedbackCount: Int?,
        isFavorite: Bool
    ) {
        self.id = id
        self.coordinate = coordinate
        self.name = name
        self.shortDescription = shortDescription
        self.images = images
        self.rating = rating
        self.workTime = workTime
        self.tags = tags
        self.feedbackCount = feedbackCount
        self.isFavorite = isFavorite
    }

    func withFavoriteStatus(to status: Bool) -> Place {
        return Place(
            id: id,
            coordinate: coordinate,
            name: name,
            shortDescription: shortDescription,
            images: images,
            rating: rating,
            workTime: workTime,
            tags: tags,
            feedbackCount: feedbackCount,
            isFavorite: status
        )
    }
}

extension Place: Equatable {
    public static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id && lhs.coordinate.latitude == rhs.coordinate.latitude &&
            lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.name == rhs.name
    }
}
