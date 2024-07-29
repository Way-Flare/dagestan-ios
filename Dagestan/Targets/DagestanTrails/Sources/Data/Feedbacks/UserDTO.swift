//
//  UserDTO.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct UserDTO: Decodable {
    let username: String
    let avatar: String?
}

// MARK: - Domainable

extension UserDTO: Domainable {
    func asDomain() -> User {
            // swiftlint:disable:next force_unwrapping
        let avatarURL = avatar != nil ? URL(string: avatar!): nil
        return User(
            username: username,
            avatarURL: avatarURL
        )
    }
}
