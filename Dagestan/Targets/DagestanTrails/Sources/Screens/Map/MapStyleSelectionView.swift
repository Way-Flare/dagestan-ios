//
//  MapStyleSelectionView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import MapboxMaps
import DesignSystem
import SwiftUI

/// Энам содержащий поддерживаемые типы карты и названия для них
enum MapType: CaseIterable {
    case streets
    case satelliteStreets
    case dark
    case outdoors

    var mapStyle: MapStyle {
        switch self {
            case .dark:
                return .dark
            case .streets:
                return .streets
            case .satelliteStreets:
                return .satelliteStreets
            case .outdoors:
                return .outdoors
        }
    }

    var name: String {
        switch self {
            case .dark:
                return "Темная карта"
            case .streets:
                return "Универсальная карта"
            case .satelliteStreets:
                return "Спутниковая карта"
            case .outdoors:
                return "Обычная светлая карта"
        }
    }
}

/// Вью модалка со списком стилей карт для выбора
struct MapStyleSelectionView: View {
    /// Выбранный стиль карты
    var didSelectStyle: ((MapStyle) -> Void)?
    
    // MARK: - Initializer

    /// Текущий выбранный стиль
    let selectedStyle: MapStyle

    /// Заголовок с крестиком
    private var title: some View {
        HStack {
            Text("Выберите тип карты")
                .font(.manropeSemibold(size: Grid.pt24))
                .foregroundStyle(WFColor.foregroundPrimary)

            Spacer()

            CloseButton()
        }
        .padding()
    }

    var body: some View {
        VStack(alignment: .leading) {
            title
            ForEach(MapType.allCases, id: \.self) { type in
                Button {
                    didSelectStyle?(type.mapStyle)
                } label: {
                    HStack {
                        Text(type.name)
                            .font(.manropeRegular(size: Grid.pt16))
                            .foregroundStyle(WFColor.foregroundPrimary)
                            .padding(.leading, Grid.pt16)
                            .padding(.bottom, Grid.pt8)
                        if selectedStyle == type.mapStyle {
                            Text("✅")
                        }
                    }
                }
            }
            Spacer()
        }
    }
}
