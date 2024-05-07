//
//  PlaceDetailView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct PlaceDetailView: View {
    @StateObject var viewModel: PlaceDetailViewModel

    init(placeId: Int, service: IPlacesService) {
        _viewModel = StateObject(wrappedValue: PlaceDetailViewModel(service: service, placeId: placeId))
    }

    var body: some View {
        VStack {
            if let placeDetail = viewModel.place {
                Text(placeDetail.description)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.loadPlaceDetail()
        }
    }
}
