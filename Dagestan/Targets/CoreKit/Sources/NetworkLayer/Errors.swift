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
    case emptyResponse

    public var message: String {
        switch self {
            case .failedDecode:
                return "Ошибка декодирования"
            case .invalidURL:
                return "Неккоректный URL"
            case .unauthorized:
                return "Необходима авторизация"
            case let .serverError(error):
                return error.detail

            default:
                return "Произошла неизвестная ошибка"
        }
    }
}

public struct ServerError: Decodable {
    public let detail: String
}
