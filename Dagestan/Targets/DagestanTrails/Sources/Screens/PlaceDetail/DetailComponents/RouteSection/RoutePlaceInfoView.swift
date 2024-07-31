//
//  RoutePlaceInfoView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct PlaceRouteInfoView: View {
    let title: String
    let items: [RoutePlaceModel]?
    let isRoutes: Bool
    let countRoutes: Int
    let routeService: IRouteService?
    let placeService: IPlacesService?
    var onFavoriteAction: (() -> Void)?
    
    init(
        type: InfoType,
        items: [RoutePlaceModel]?,
        routeService: IRouteService? = nil,
        placeService: IPlacesService? = nil,
        onFavoriteAction: (() -> Void)? = nil
    ) {
        self.title = type.title
        self.items = items
        self.isRoutes = type.isRoutes
        self.countRoutes = type.countRoutes
        self.routeService = routeService
        self.placeService = placeService
        self.onFavoriteAction = onFavoriteAction
    }
    
    var body: some View {
        if let items {
            VStack(alignment: .leading, spacing: Grid.pt12) {
                HStack(spacing: Grid.pt8) {
                    Text(title)
                        .font(.manropeSemibold(size: Grid.pt18))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    
                    if !isRoutes {
                        DagestanTrailsAsset.routingBulk.swiftUIImage
                            .resizable()
                            .frame(width: Grid.pt16, height: Grid.pt16)
                            .padding(.vertical, Grid.pt4)
                            .padding(.horizontal, Grid.pt6)
                            .background(WFColor.surfaceSecondary)
                    } else {
                        Text(String(countRoutes))
                            .foregroundStyle(WFColor.foregroundSoft)
                            .font(.manropeSemibold(size: 18))
                    }
                }
                RoutePlacesView(
                    isRoutes: isRoutes, 
                    items: items,
                    routeService: routeService,
                    placeService: placeService,
                    onFavoriteAction: onFavoriteAction
                )
            }
        }
    }
}

extension PlaceRouteInfoView {
    enum InfoType {
        case place(title: String)
        case route(title: String, count: Int)
        
        var title: String {
            switch self {
                case let .place(title):
                    return title
                case let .route(title, _):
                    return title
            }
        }
        
        var isRoutes: Bool {
            switch self {
                case .place:
                    return false
                case .route:
                    return true
            }
        }
        
        var countRoutes: Int {
            switch self {
                case .place:
                    return 0
                case let .route(_, count):
                    return count
            }
        }
    }
}

#Preview {
    PlaceRouteInfoView(
        type: .place(title: "Это место в маршрутах"),
        items: PlaceDetail.mock().routes.map { $0.asDomain() }
    )
}
