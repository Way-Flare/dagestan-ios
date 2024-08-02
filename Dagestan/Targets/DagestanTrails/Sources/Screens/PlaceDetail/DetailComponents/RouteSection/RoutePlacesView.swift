//
//  RoutePlacesView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 16.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct RoutePlacesView: View {
    @State private var isExpanded = false
    let isRoutes: Bool
    let items: [RoutePlaceModel]
    let routeService: IRouteService?
    let placeService: IPlacesService?
    let onFavoriteAction: (() -> Void)?
    
    @ViewBuilder
    private func view(for item: RoutePlaceModel) -> some View {
        if isRoutes {
            if let routeService, let placeService {
                PlaceDetailView(
                    viewModel: PlaceDetailViewModel(
                        service: placeService,
                        placeId: item.id,
                        isFavorite: item.isFavorite
                    ),
                    routeService: routeService,
                    onFavoriteAction: onFavoriteAction
                )
            }
        } else {
            if let routeService, let placeService {
                RouteDetailView(
                    viewModel: RouteDetailViewModel(service: routeService, id: item.id),
                    placeService: placeService,
                    onFavoriteAction: onFavoriteAction
                )
            }
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .zero) {
                itemsContainerView
                expandButton
            }
        }
        .scrollIndicators(.hidden)
    }

    @ViewBuilder private var itemsContainerView: some View {
        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
            if isExpanded || index < 5 {
                NavigationLink(destination: view(for: item)) {
                    VStack(alignment: .leading, spacing: .zero) {
                        numberedItemView(index: index, item: (item.title, item.subtitle))
                        if (index < items.count - 1) && (isExpanded || index < 4) {
                            dividerView
                        }
                    }
                }
                .buttonStyle(DSPressedButtonStyle())
            }
        }
    }

    @ViewBuilder private var expandButton: some View {
        let placesCount = items.count - 5
        let placesText = pluralPlaces(count: placesCount)

        if items.count > 5 {
            WFButton(
                title: isExpanded ? "Свернуть" : "Показать еще \(placesCount) \(placesText)",
                size: .m,
                state: .default,
                type: .secondary
            ) {
                withAnimation(.interactiveSpring) {
                    isExpanded.toggle()
                }
            }
            .padding(.top, Grid.pt12)
        }
    }

    private var dividerView: some View {
        RoundedRectangle(cornerRadius: Grid.pt12)
            .fill(WFColor.accentMuted)
            .frame(width: Grid.pt1, height: Grid.pt12)
            .padding(.leading, Grid.pt8)
    }

    private func numberedItemView(index: Int, item: (String, String?)) -> some View {
        HStack {
            numberStack(index: index)

            ItemRowView(
                image: DagestanTrailsAsset.tree.swiftUIImage,
                title: item.0,
                subtitle: item.1,
                isRoutes: isRoutes
            )
        }
    }

    private func numberStack(index: Int) -> some View {
        VStack(spacing: .zero) {
            if index == 0 && isRoutes {
                DagestanTrailsAsset.locationBulk.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Grid.pt16, height: Grid.pt16)
                    .foregroundStyle(WFColor.iconAccent)
            } else if index == items.count - 1 && isRoutes {
                DagestanTrailsAsset.flagBulk.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Grid.pt16, height: Grid.pt16)
                    .foregroundStyle(WFColor.iconAccent)
            }

            Text(String(format: "%02d", index + 1))
                .font(.manropeSemibold(size: Grid.pt18))
                .foregroundColor(WFColor.foregroundMuted)
        }
        .isHidden(!isRoutes)
    }

    func pluralPlaces(count: Int) -> String {
        let number = count % 100
        if number >= 11 && number <= 19 {
            return "мест"
        } else {
            switch number % 10 {
                case 1:
                    return "место"
                case 2, 3, 4:
                    return "места"
                default:
                    return "мест"
            }
        }
    }
}
