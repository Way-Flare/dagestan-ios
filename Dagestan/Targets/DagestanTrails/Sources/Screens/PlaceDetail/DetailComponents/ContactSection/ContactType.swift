//
//  ContactType.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 22.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreLocation
import SwiftUI

enum ContactType {
    case phone(with: String?)
    case email(with: String?)
    case site(with: String?)
    case location(with: String?)
    case coordinates(coordinate: CLLocationCoordinate2D?)

    var text: String? {
        switch self {
            case let .phone(text), let .email(text), let .location(text), let .site(text):
                return text
            case let .coordinates(coordinate):
                guard let coordinate else { return nil }
                return "\(coordinate.latitude), \(coordinate.longitude)"
        }
    }
    
    var icon: Image {
        switch self {
            case .phone:
                DagestanTrailsAsset.callLinear.swiftUIImage
            case .email:
                DagestanTrailsAsset.smsLinear.swiftUIImage
            case .coordinates:
                DagestanTrailsAsset.globalLinear.swiftUIImage
            case .location:
                DagestanTrailsAsset.locationLinear.swiftUIImage
            case .site:
                DagestanTrailsAsset.globalLinear.swiftUIImage
        }
    }
}
