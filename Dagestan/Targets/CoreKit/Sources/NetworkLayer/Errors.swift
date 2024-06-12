//
//  Errors.swift
//  CoreKit
//
//  Created by Abdulaev Ramazan on 14.04.2024.
//

import Foundation

public enum RequestError: Error {
    case failedDecode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case serverError(ServerError)
    case unknown

    var message: String {
        switch self {
            case .failedDecode:
                return "Decode error"
            case .invalidURL:
                return "invalid URL"
            case .unauthorized:
                return "Need authorization token"
            default:
                return "Unknown error"
        }
    }
}

public struct ServerError: Decodable {
    let code: String
    let message: String
}
