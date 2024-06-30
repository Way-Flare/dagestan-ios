//
//  AuthToken.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 30.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

struct AuthToken: Decodable {
    let access: String
    let refresh: String
}
