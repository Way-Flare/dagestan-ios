//
//  Mock.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

final class MockRouteService: IRouteService {
    func getAllRoutes() async throws -> [Route] {
        return [
            Route(
                id: 1,
                title: "Route 1",
                images: [],
                shortDescription: "Short description",
                distance: 10,
                travelTime: "1 hour",
                feedbackCount: 10,
                rating: 4.5,
                isFavorite: true
            )
        ]
    }

    // swiftlint: disable line_length
    func getRoute(id: Int) async throws -> RouteDetail {
        return RouteDetail(
            id: 1,
            title: "Дагестан – Москва и длинный заголовок, а может быть вообще очень длинным, хоть в четыре строчки",
            images: Place.mock.images,
            shortDescription: "aspfkaspofk",
            description: "Маршрут \"Дагестанский квест\": Погрузитесь в магию Дагестана, начав путешествие с его сердца. Посетите древние крепости, окунитесь в аутентичную культуру в горных деревнях и насладитесь величественными видами природы. Под покровом звёзд переночуйте в традиционных гостевых домах, попробуйте изысканные кавказские блюда. Затем отправляйтесь в столицу, оставив за собой память о волшебных моментах, прожитых в этом удивительном уголке России.",
            places: [
                RouteDetail.PlaceInRoute(
                    id: 1,
                    name: "easfkasf",
                    images: Place.mock.images,
                    workTime: "10:00 - 20:00",
                    mainTag: TagPlace.food,
                    sequence: 1,
                    isFavorite: false
                ),
                RouteDetail.PlaceInRoute(
                    id: 2, 
                    name: "qowfoqwfwqofiz",
                    images: Place.mock.images,
                    workTime: "13:00 - 20:00",
                    mainTag: TagPlace.landmark,
                    sequence: 2,
                    isFavorite: true
                )
            ],
            distance: 45.32,
            travelTime: "3д 12ч",
            feedbackCount: 0,
            rating: 5.0,
            isFavorite: true
        )
    }
    // swiftlint: enable line_length
}
