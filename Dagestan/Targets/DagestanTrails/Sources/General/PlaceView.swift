//
//  PlaceView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

struct PlaceView: View {
    let service: IPlacesService
    let place: Place?
    @State private var isShowingDetail = false

    var body: some View {
        VStack {
            Text(place?.name ?? "Unknown")
                .padding()
                .background(.indigo)
            Button("View Details") {
                isShowingDetail = true
            }
        }
        .sheet(isPresented: $isShowingDetail) {
            if let placeId = place?.id {
                PlaceDetailView(placeId: placeId, service: service)
            }
        }
    }
}
