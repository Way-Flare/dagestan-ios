//
//  Errors.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 14.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case failedDecode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case serverError(ServerError)
    case emptyData
    case unknown

    var message: String {
        switch self {
            case .failedDecode:
                return "Decode error"
            case .invalidURL:
                return "invalid URL"
            case .unauthorized:
                return "Need authorization token"
            case .emptyData:
                return "Empty data from response"
            default:
                return "Unknown error"
        }
    }
}

public struct ServerError: Decodable {
    let code: String
    let message: String
}
