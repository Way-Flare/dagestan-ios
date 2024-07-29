//
//  ProfileDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct ProfileDTO: Decodable {
    let id: Int
    let avatar: String?
    let username: String?
    let phone: String
    let email: String?
}

extension ProfileDTO: Domainable {
    typealias DomainType = Profile

    func asDomain() -> Profile {
        Profile(
            id: id,
            avatar: URL(string: avatar ?? ""),
            username: username,
            phone: phone,
            email: email
        )
    }
}
