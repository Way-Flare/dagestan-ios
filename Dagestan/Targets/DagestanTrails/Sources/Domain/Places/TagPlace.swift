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
    case landmark
    case unknown
}

extension TagPlace {
    var name: String {
        switch self {
            case .nature:
                return "Природа"
            case .landmark:
                return "Достопримечательность"
            case .food:
                return "Еда"
            case .unknown:
                return "Неизвестно"
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
            case .unknown:
                return Image(systemName: "eye")
        }
    }
}
