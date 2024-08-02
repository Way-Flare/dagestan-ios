//
//  PlaceFeedbackList.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct PlaceFeedbackList {
    public let count: Int
    public let next: URL?
    public let previous: URL?
    public let results: [PlaceFeedback]
        
    public init(count: Int, next: URL?, previous: URL?, results: [PlaceFeedback]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
