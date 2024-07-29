//
//  ProfileRequestDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

struct ProfileRequestDTO {
    let username: String
    let email: String

    func toDict() -> [String: Any] {
        return [
            "username": username,
            "email": email
        ]
    }
}
