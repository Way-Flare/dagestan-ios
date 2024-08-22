//
//  TagPlace.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 24.04.2024.
//

import CoreKit
import SwiftUI

public enum TagPlace: String, CaseIterable {
    case nature
    case food
    case activity
    case landmark
    case habitation
    case shops
    case unknown

    public init(rawValue: String) {
        self = TagPlace.allCases.first { $0.rawValue == rawValue } ?? .unknown
    }
}

extension TagPlace {
    var name: String {
        switch self {
            case .nature:
                return "Природа"
            case .landmark:
                return "Достопримечательности"
            case .food:
                return "Еда"
            case .activity:
                return "Развелечения"
            case .unknown:
                return rawValue
            case .habitation:
                return "Жилье"
            case .shops:
                return "Магазины"
        }
    }

    var icon: Image {
        switch self {
            case .nature:
                return Image(systemName: "tree")
            case .landmark:
                return Image(systemName: "building.columns")
            case .food:
                return Image(systemName: "fork.knife")
            case .activity:
                return Image(systemName: "theatermasks")
            case .habitation:
                return Image(systemName: "house")
            case .shops:
                return Image(systemName: "storefront")
            default:
                return Image(systemName: "eye")
        }
    }
}
