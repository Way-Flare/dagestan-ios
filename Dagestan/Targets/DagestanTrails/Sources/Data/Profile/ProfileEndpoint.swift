//
//  ProfileEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 29.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

enum ProfileEndpoint {
    case getProfile
    case patchProfile(request: ProfileRequestDTO)
    case deleteProfile
}

extension ProfileEndpoint: ApiEndpoint {
    var path: String {
        "profile"
    }

    var method: CoreKit.Method {
        switch self {
            case .getProfile: return .get
            case .patchProfile: return .patch
            case .deleteProfile: return .delete
        }
    }

    var headers: Headers? {
        guard let data = KeychainService.load(key: ConstantAccess.accessTokenKey),
              let token = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }

    var body: Parameters? {
        var parameters: Parameters?

        switch self {
            case let .patchProfile(request):
                parameters = request.toDict()
            default:
                parameters = nil
        }

        return parameters
    }
}
