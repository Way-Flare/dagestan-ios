//
//  NavigationRoute.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import Foundation

enum AuthNavigationRoute: Hashable {
    case passwordCreation(phone: String)
    case register
    case verification(isRecovery: Bool)
    case recoveryPassword
}
