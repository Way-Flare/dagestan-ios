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
    case patchProfile(request: PatchType)
    case deleteProfile
}

extension ProfileEndpoint: ApiEndpoint {
    var path: String {
        "profile/"
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
        
        var parameters = [
            "Content-Type": "application/json"
        ]
        
        if case .patchProfile(let request) = self {
            parameters["field-modify"] = request.value
        }
        
        return parameters
    }

    var body: Parameters? {
        if case .patchProfile(let request) = self {
            switch request {
                case .name(let value):
                    return ["username": value]
                case .email(let value):
                    return ["email": value]
                case .photo(let value):
                    return ["avatar": value]
            }
        }
        
        return nil
    }
}

extension ProfileEndpoint {
    enum PatchType: Decodable {
        case name(value: String)
        case email(value: String)
        case photo(value: Data)
        
        var value: String {
            switch self {
                case .name: return "username"
                case .email: return "email"
                case .photo: return "avatar"
            }
        }
    }
}
