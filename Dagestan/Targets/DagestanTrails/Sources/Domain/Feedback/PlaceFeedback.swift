//
//  PlaceFeedback.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct PlaceFeedback: Hashable {
    public let id: Int
    public let images: [URL]
    public let user: User
    public let stars: Int
    public let comment: String?
    public let createdAt: String
    
    public static func == (lhs: PlaceFeedback, rhs: PlaceFeedback) -> Bool {
        lhs.id == rhs.id
    }
}
