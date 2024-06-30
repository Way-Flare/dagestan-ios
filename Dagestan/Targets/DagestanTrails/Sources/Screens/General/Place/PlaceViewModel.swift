//
//  PlaceViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.05.2024.
//

import Combine
import DesignSystem
import SwiftUI

final class PlaceViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var place: Place
    @Published var isSelectedFavorite = false
    @Published var isActive = false

    var currentFavoriteImage: Image {
        isSelectedFavorite ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }
    
    var currentFavoriteColor: Color {
        isSelectedFavorite ? WFColor.errorSoft : WFColor.iconInverted
    }
    
    lazy var formatter = TimeSuffixFormatter(workTime: place.workTime)

    init(place: Place) {
        self.place = place
    }

    func onClose() {
        print("close action")
    }

    func onFavorite() {
        isSelectedFavorite.toggle()
        print("favorite action")
    }
}
