//
//  MapStyleSelectionView.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import MapboxMaps
import MapboxCommon
import DesignSystem
import SwiftUI

@available(iOS 14.0, *)
class StandardStyleLocationsModel: ObservableObject, Equatable {

    static func == (lhs: StandardStyleLocationsModel, rhs: StandardStyleLocationsModel) -> Bool {
        return lhs.lightPreset == rhs.lightPreset &&
        lhs.poi == rhs.poi &&
        lhs.transitLabels == rhs.transitLabels &&
        lhs.placeLabels == rhs.placeLabels &&
        lhs.showRoadsAndTransit == rhs.showRoadsAndTransit &&
        lhs.show3DObjects == rhs.show3DObjects &&
        lhs.style == rhs.style &&
        lhs.theme == rhs.theme
    }

    @Published var lightPreset: StandardLightPreset = .day
    @Published var poi = true
    @Published var transitLabels = true
    @Published var placeLabels = true
    @Published var roadLabels = true
    @Published var showRoadsAndTransit = true
    @Published var showPedestrianRoads = true
    @Published var show3DObjects = true
    @Published var style: Style = .standard
    @Published var theme: StandardTheme = .default

    enum Style {
        case standard
        case standardSatellite
    }
}

@available(iOS 14.0, *)
struct MapStyleSelectionView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var model: StandardStyleLocationsModel
    /// Выбранный стиль карты
    var didSelectStyle: ((StandardLightPreset) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Закрыть")
                }
            }

            Picker("Style", selection: $model.style) {
                Text("Стандарт").tag(StandardStyleLocationsModel.Style.standard)
                Text("Спутник").tag(StandardStyleLocationsModel.Style.standardSatellite)
            }.pickerStyle(.segmented)
            HStack {
                Text("Освещение")
                Picker("Light", selection: $model.lightPreset) {
                    Text("Рассвет").tag(StandardLightPreset.dawn)
                    Text("День").tag(StandardLightPreset.day)
                    Text("Сумерки").tag(StandardLightPreset.dusk)
                    Text("Ночь").tag(StandardLightPreset.night)
                }
                .pickerStyle(.segmented)


            }

            if model.style == .standard {
                HStack {
                    Text("Тема")
                    Picker("Theme", selection: $model.theme) {
                        Text("Обычная").tag(StandardTheme.default)
                        Text("Блеклый").tag(StandardTheme.faded)
                        Text("Монохромный").tag(StandardTheme.monochrome)
                    }.pickerStyle(.segmented)
                }
            }

            // MARK: Доп настройка стиля карты. Позволяет вкл/выкл отображение разных деталей на карте. Нет нужды в релизе
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    Text("Labels")
//                    Group {
//                        Toggle("Пои", isOn: $model.poi)
//                        Toggle("Транзит", isOn: $model.transitLabels)
//                        Toggle("Places", isOn: $model.placeLabels)
//                        Toggle("Дороги", isOn: $model.roadLabels)
//                        switch model.style {
//                            case .standard:
//                                Toggle("3D-объекты", isOn: $model.show3DObjects)
//                            case .standardSatellite:
//                                Toggle("Roads&Transit", isOn: $model.showRoadsAndTransit)
//                                Toggle("Pedestrian roads", isOn: $model.showPedestrianRoads)
//                        }
//                    }
//                    .fixedSize()
//                    .font(.footnote)
//                }.toggleStyle(.button)
//            }
        }
        .padding(Grid.pt10)
    }

}
