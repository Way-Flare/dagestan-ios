//
//  RoutePlaceModle.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 22.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct RoutePlaceModel {
    public let icon: Image
    public let title: String
    public let subtitle: String?
    
    public init(
        icon: Image,
        title: String,
        subtitle: String?
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
    }
}
