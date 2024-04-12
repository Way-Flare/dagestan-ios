//
//  RequestEncoder.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 12.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

class RequestEncoder {
    static func json(parameters: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print(error)
            return nil
        }
    }
}
