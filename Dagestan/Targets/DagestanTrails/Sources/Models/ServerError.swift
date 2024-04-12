//
//  ServerError.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 12.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

struct ServerError: Decodable {
    let code: String
    let msg: String
}
