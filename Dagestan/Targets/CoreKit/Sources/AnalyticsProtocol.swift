//
//  AnalyticsProtocol.swift
//  CoreKit
//
//  Created by Ramazan Abdulaev on 30.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public protocol AnalyticsProtocol {
    var eventId: String { get }
    var parameters: [String: Any] { get }
}

