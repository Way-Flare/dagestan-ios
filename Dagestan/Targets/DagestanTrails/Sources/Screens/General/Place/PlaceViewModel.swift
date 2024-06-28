//
//  PlaceViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.05.2024.
//

import Combine
import DesignSystem
import SwiftUI

protocol IPlaceViewModel: ObservableObject {
    var place: Place? { get set }
    var isSelectedFavorite: Bool { get set }
    var isActive: Bool { get set }
    var currentFavoriteImage: Image { get }
    var currentFavoriteColor: Color { get }
    
    func onClose()
    func onFavorite()
}

final class PlaceViewModel: IPlaceViewModel {
    @Published var place: Place?
    @Published var isSelectedFavorite = false
    @Published var isActive = false

    var currentFavoriteImage: Image {
        isSelectedFavorite ? Image(systemName: "heart.fill") : Image(systemName: "heart")
    }
    
    var currentFavoriteColor: Color {
        isSelectedFavorite ? WFColor.errorSoft : WFColor.iconInverted
    }
    
    init(place: Place?) {
        self.place = place
    }

    func onClose() {
        place = nil
        print("close action")
    }

    func onFavorite() {
        isSelectedFavorite.toggle()
        print("favorite action")
    }
}
