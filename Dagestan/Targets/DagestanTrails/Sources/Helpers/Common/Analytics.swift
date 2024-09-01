//
//  Analytics.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 30.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import AppMetricaCore
import CoreKit

public final class Analytics {
    public static let shared = Analytics()

    private init() {}

    func report(event: AnalyticsProtocol) {
        AppMetrica.reportEvent(name: event.eventId, parameters: event.parameters) { error in
            print("Failed report event. Error:", error)
        }
    }
}

