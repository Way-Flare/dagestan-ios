//
//  PlaceFeedbackList.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

struct PlaceFeedbackList {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PlaceFeedback]
}
