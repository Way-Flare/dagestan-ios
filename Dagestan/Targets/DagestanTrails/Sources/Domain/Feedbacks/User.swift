//
//  User.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct User: Hashable {
    public let username: String
    public let avatarURL: URL?
    
    public init(username: String, avatarURL: URL?) {
        self.username = username
        self.avatarURL = avatarURL
    }
}
