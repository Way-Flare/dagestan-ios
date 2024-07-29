//
//  PlaceFeedback.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

struct PlaceFeedback: Hashable {
    let id: Int
    let images: [URL]
    let user: User
    let stars: Int
    let comment: String?
    let createdAt: String
}
