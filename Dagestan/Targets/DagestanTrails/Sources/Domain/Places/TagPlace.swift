//
//  TagPlace.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 24.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DagestanKit
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
                return DagestanKitAsset.essentialTreeLinear.swiftUIImage
            case .landmark:
                return DagestanKitAsset.essentialForkDefault.swiftUIImage
            case .food:
                return DagestanKitAsset.buildingCourthouseLinear.swiftUIImage
            case .unknown:
                return DagestanKitAsset.supportMessageQuestionLinear.swiftUIImage
        }
    }
}
