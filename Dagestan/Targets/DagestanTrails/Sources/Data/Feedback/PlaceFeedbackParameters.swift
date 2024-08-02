//
//  PlaceFeedbackParameters.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 02.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct PlaceFeedbackParametersDTO: Encodable {
    public let id: Int
    public let pageSize: Int?
    public let pages: Int?
    
    public init(id: Int, pageSize: Int?, pages: Int?) {
        self.id = id
        self.pageSize = pageSize
        self.pages = pages
    }
}
