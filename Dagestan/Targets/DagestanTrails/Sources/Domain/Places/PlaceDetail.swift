//
//  PlaceDetail.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.04.2024.
//

import CoreLocation
import CoreKit

struct PlaceDetail {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    let name: String
    let tags: [TagPlace]
    let shortDescription: String?
    let description: String?
    let images: [URL]
    let workTime: String?
    let rating: Double
    let placeWays: [PlaceWay]
    let contacts: [Contact]
    let routes: [Route]
    let feedbackCount: Int
    let isFavorite: Bool
}

extension PlaceDetail {
    struct PlaceFeedback: Hashable {
        let id: Int
        let images: [URL]
        let user: User
        let stars: Int
        let comment: String?
        let createdAt: String
    }

    struct User: Hashable {
        let username: String
        let avatar: String
    }

    struct PlaceWay {
        let id: Int
        let info: String?
        let images: [URL]
    }

    struct Contact {
        let id: Int
        let phoneNumber: String?
        let email: String?
    }

    struct Route {
        let id: Int
        let title: String
        let shortDescription: String?
        let images: [URL]
        let rating: Int
        let isFavorite: Bool
    }
}

extension PlaceDetail.Route: Domainable {
    typealias DomainType = RoutePlaceModel
    
    func asDomain() -> DomainType {
        .init(
            id: id,
            icon: TagPlace.nature.icon,
            title: title,
            subtitle: shortDescription,
            isFavorite: isFavorite
        )
    }
}

// Моканная модель данных
extension PlaceDetail {
    static func mock() -> PlaceDetail {
        return PlaceDetail(
            id: 1,
            coordinate: CLLocationCoordinate2D(latitude: 43.206536, longitude: 46.861794),
            name: "Некрасовка",
            tags: [.landmark, .food],
            shortDescription: "Краткое описание места",
            description: "Подробное описание местаnripwl bnwrpoi bnporwnbpiorenbpiwrenbpiwnrpbiwroepbnpwoier nbpiownerbiponerpbionrwepiobnopiwernpoie w fopweopfkopewopfopewkfopewkfopewop fweopfk opwekfopewkfopewkop fopwefkopewkopfwop kfopwekopf weopfopwek opfewopfkwopkfopwq ioegwepiolgjweipogjweioprgjoiergpiower ngpiernpren bwrnepi bwreiop bjwerpiobjwrepibjpweorjbpier2jbpior4piobwrpio b",
            images: Place.mock.images,
            workTime: "09:00 - 18:00",
            rating: 5,
            placeWays: [.mock()],
            contacts: [.mock()],
            routes: [.mock()],
            feedbackCount: 2,
            isFavorite: true
        )
    }
}

extension PlaceDetail.PlaceFeedback {
    static func mock() -> PlaceDetail.PlaceFeedback {
        return PlaceDetail.PlaceFeedback(
            id: Int.random(in: 1...100),
            images: Place.mock.images,
            user: .mock(),
            stars: 4,
            comment: "Отличное место для посещения",
            createdAt: "24.04.2024"
        )
    }
}

extension PlaceDetail.User {
    static func mock() -> PlaceDetail.User {
        return PlaceDetail.User(username: "user1", avatar: "https://example.com/avatar1.jpg")
    }
}

extension PlaceDetail.PlaceWay {
    static func mock() -> PlaceDetail.PlaceWay {
        return PlaceDetail.PlaceWay(
            id: 1,
            info: "Информация о пути",
            images: [URL(string: "https://example.com/image3.jpg")!]
        )
    }
}

extension PlaceDetail.Contact {
    static func mock() -> PlaceDetail.Contact {
        return PlaceDetail.Contact(
            id: 1,
            phoneNumber: nil,
            email: "info@example.com"
        )
    }
}

extension PlaceDetail.Route {
    static func mock() -> PlaceDetail.Route {
        return PlaceDetail.Route(
            id: 1,
            title: "Маршрут 1",
            shortDescription: "Краткое описание маршрута",
            images: [URL(string: "https://example.com/image4.jpg")!],
            rating: 4,
            isFavorite: true
        )
    }
}

extension PlaceDetail: Equatable {
    static func == (lhs: PlaceDetail, rhs: PlaceDetail) -> Bool {
        lhs.id == rhs.id
    }
}
