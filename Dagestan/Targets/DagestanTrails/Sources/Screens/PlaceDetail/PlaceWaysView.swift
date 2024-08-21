//
//  PlaceWaysView.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 19.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import NukeUI
import SwiftUI

@MainActor
struct PlaceWaysView: View {
    @State var selectedIndex: IdentifiableInt?
    let placeWay: PlaceDetail.PlaceWay
    let isFood: Bool

    var body: some View {
        ContainerTitleView(title: isFood ? "Меню" : "Советы и подсказки") {
            VStack(alignment: .leading, spacing: Grid.pt12) {
                if let info = placeWay.info {
                    ExpandableTextView(text: info, lineLimit: 8) { isExpanded in
                        Text(isExpanded ? "свернуть" : "раскрыть")
                            .underline()
                    }
                    .foregroundStyle(WFColor.foregroundPrimary)
                }

                ScrollView(.horizontal) {
                    HStack(alignment: .firstTextBaseline, spacing: .zero) {
                        ForEach(placeWay.images.indices) { index in
                            placeWayContent(with: placeWay.images[index], isFood: isFood)
                                .onTapGesture {
                                    selectedIndex = IdentifiableInt(id: index)
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .fullScreenCover(item: $selectedIndex) { index in
            FullScreenImageGallery(
                images: placeWay.images.compactMap { $0.asDomain() },
                selectedIndex: index.id
            )
        }
    }

    func placeWayContent(with image: ImageDTO, isFood: Bool) -> some View {
        VStack(alignment: .leading, spacing: Grid.pt8) {
            LazyImage(url: image.asDomain()) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Grid.pt96, height: Grid.pt96)
                        .cornerStyle(.constant(Grid.pt16))
                } else if state.isLoading {
                    Rectangle()
                        .fill()
                        .frame(width: Grid.pt96, height: Grid.pt96)
                        .skeleton()
                        .cornerStyle(.constant(Grid.pt16))
                }
            }

            if let name = image.trimmedName, isFood {
                VStack(alignment: .leading, spacing: Grid.pt4) {
                    Text(name)
                        .font(.manropeSemibold(size: Grid.pt14))
                        .foregroundStyle(WFColor.foregroundPrimary)
                        .lineLimit(2)

                    if let items = image.items, !items.isEmpty {
                        ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                            Text(item)
                                .font(.manropeSemibold(size: Grid.pt12))
                                .foregroundStyle(WFColor.foregroundSoft)
                                .lineLimit(2)
                        }
                    }
                }
                .frame(width: Grid.pt120, alignment: .leading)
            }
        }
    }
}
