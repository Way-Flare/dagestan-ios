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

        if case .patchProfile(let request) = self {
            return ["field-modify": request.value]
        }

        return nil
    }

    var body: Parameters? {
        if case .patchProfile(let request) = self {
            switch request {
                case .name(let value):
                    return ["username": value]
                case .email(let value):
                    return ["email": value]
                case .photo(value: let value):
                    return nil
            }
        }

        return nil
    }

    var multipartFormData: [MultipartFormData]? {
        switch self {
            case .patchProfile(let request):
                switch request {
                    case .photo(let value):
                        return [
                            MultipartFormData(
                                data: value,
                                name: "avatar",
                                fileName: "avatar.jpg",
                                mimeType: "image/jpeg"
                            )
                        ]
                    default:
                        return nil
                }
            default:
                return nil
        }
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
