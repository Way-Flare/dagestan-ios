//
//  PlaceContactInformationView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 17.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation
import DesignSystem
import SwiftUI

struct PlaceContactInformationView: View {
    @State private var address = "Загрузка адреса..."
    @Binding var isVisible: Bool

    let place: PlaceDetail?

    var body: some View {
        if let place {
            VStack(alignment: .leading, spacing: Grid.pt24) {
                VStack(alignment: .leading, spacing: Grid.pt8) {
                    Text("Контакты")
                        .font(.manropeSemibold(size: Grid.pt18))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    if let contact = place.contacts.first {
                        VStack(alignment: .leading, spacing: Grid.pt4) {
                            ContactView(
                                isVisible: $isVisible,
                                type: .phone(with: contact.phoneNumber)
                            ) {
                                if let phone = contact.phoneNumber,
                                   let url = URL(string: "tel://\(phone)") {
                                    UIApplication.shared.open(url)
                                }
                            }
                            ContactView(
                                isVisible: $isVisible,
                                type: .email(with: contact.email)
                            )
                        }
                    }
                }

                VStack(alignment: .leading, spacing: Grid.pt8) {
                    let _ = getLocation(by: CLLocation(
                            latitude: place.coordinate.latitude,
                            longitude: place.coordinate.longitude
                        )
                    )
                    Text("Адрес")
                        .font(.manropeSemibold(size: Grid.pt18))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    ContactView(
                        isVisible: $isVisible,
                        type: .location(with: address)
                    )
                    ContactView(
                        isVisible: $isVisible,
                        type: .coordinates(coordinate: place.coordinate)
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Grid.pt12)
            .background(WFColor.surfacePrimary)
            .cornerStyle(.constant(Grid.pt12))
        }
    }

    func getLocation(by location: CLLocation) { // этого не будет когда бек подключит адресф
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Ошибка геокодирования: \(error)")
                self.address = "Адрес не найден"
                return
            }
            self.address = placemarks?.first.map {
                "\($0.thoroughfare ?? "Улица неизвестна"), \($0.subThoroughfare ?? "")"
            } ?? "Адрес не найден"
        }
    }
}

#Preview {
    PlaceContactInformationView(isVisible: .constant(false), place: PlaceDetail.mock())
}
