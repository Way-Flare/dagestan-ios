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
    @Binding var isVisible: Bool

    let place: PlaceDetail?

    var body: some View {
        if let place {
            VStack(alignment: .leading, spacing: Grid.pt24) {
                VStack(alignment: .leading, spacing: Grid.pt8) {
                    Text("Контакты")
                        .font(.manropeSemibold(size: Grid.pt18))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    VStack(alignment: .leading, spacing: Grid.pt4) {
                        ContactView(
                            isVisible: $isVisible,
                            type: .phone(with: place.contacts.first?.phoneNumber)
                        ) {
                            if let phone = place.contacts.first?.phoneNumber,
                               let url = URL(string: "tel://\(phone)") {
                                UIApplication.shared.open(url)
                            }
                        }
                        ContactView(
                            isVisible: $isVisible,
                            type: .email(with: place.contacts.first?.email)
                        )
                        ContactView(
                            isVisible: $isVisible,
                            type: .site(with: place.contacts.first?.site)
                        )
                    }
                }

                VStack(alignment: .leading, spacing: Grid.pt8) {
                    Text("Адрес")
                        .font(.manropeSemibold(size: Grid.pt18))
                        .foregroundStyle(WFColor.foregroundPrimary)
                    ContactView(
                        isVisible: $isVisible,
                        type: .location(with: place.address)
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
}
