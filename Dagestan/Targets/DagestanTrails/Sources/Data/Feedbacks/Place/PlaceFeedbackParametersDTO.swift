//
//  PlaceFeedbackParametersDTO.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

struct PlaceFeedbackParametersDTO: Encodable {
    let id: Int
    let pageSize: Int?
    let pages: Int?
}
