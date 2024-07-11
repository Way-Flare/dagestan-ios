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

extension AuthNavigationRoute: Equatable {
    static func == (lhs: AuthNavigationRoute, rhs: AuthNavigationRoute) -> Bool {
        switch (lhs, rhs) {
        case let (.passwordCreation(lhsPhone), .passwordCreation(rhsPhone)):
            return lhsPhone == rhsPhone
        case (.register, .register):
            return true
        case (.recoveryPassword, .recoveryPassword):
            return true
        case let (.verification(lhsIsRecovery), .verification(rhsIsRecovery)):
            return lhsIsRecovery == rhsIsRecovery
        default:
            return false
        }
    }
}
