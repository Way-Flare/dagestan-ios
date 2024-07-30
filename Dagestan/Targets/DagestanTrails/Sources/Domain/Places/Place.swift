//
//  Place.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//

import CoreKit
import CoreLocation

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

    func withFavoriteStatus(_ status: Bool) -> Place {
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

    static let mock: Place = .init(
        id: 19245,
        coordinate: .init(latitude: 42.9849, longitude: 47.5047),
        name: "Кайона",
        images: [
            URL(string: "https://i.pinimg.com/736x/77/26/ce/7726ceed3bea5ea2f39282ca50039d32.jpg")!,
            URL(string: "https://i.pinimg.com/564x/35/17/d2/3517d25de846560c4676fde1456dd689.jpg")!,
            URL(string: "https://i.pinimg.com/564x/9e/cc/64/9ecc6456268bcf6b79bcd985850b3bca.jpg")!,
            URL(string: "https://i.pinimg.com/564x/b0/5c/2b/b05c2b43f406c429101598cb2ea9c6db.jpg")!,
            URL(string: "https://i.pinimg.com/564x/f7/9f/95/f79f95c75040a27ef7b99f133781d99b.jpg")!,
        ],
        rating: 4.85,
        workTime: "10:00 - 20:00",
        tags: [.landmark],
        feedbackCount: 3,
        isFavorite: true
    )
}

extension Place: Equatable {
    public static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id && lhs.coordinate.latitude == rhs.coordinate.latitude &&
            lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.name == rhs.name
    }
}
