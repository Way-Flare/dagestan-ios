//
//  IKeychainService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 21.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public protocol IKeychainService {
    func save(key: String, data: Data) -> OSStatus
    func load(key: String) -> Data?
}
