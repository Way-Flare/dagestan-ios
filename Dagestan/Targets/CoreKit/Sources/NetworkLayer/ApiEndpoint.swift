//
//  ApiEndpoint.swift
//  CoreKit
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//

import Foundation

public protocol ApiEndpoint {
    typealias Parameters = [String: Any]
    typealias Headers = [String: String]

    var path: String { get }
    var method: Method { get }
    var service: String { get }
    var version: Version { get }
    var query: Parameters? { get }
    var body: Parameters? { get }
    var headers: Headers? { get }
    var multipartFormData: [MultipartFormData]? { get }
}

public enum Method: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum Version: String {
    case v1
    case v2
}

public extension ApiEndpoint {
    
    private var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        let url = URL(string: "https://dagestan-trails.ru")!

        return url
    }
    
    private var commonPath: String {
        return [service, version.rawValue, path].joined(separator: "/")
    }
    
    var url: URL {
        return baseURL.appendingPathComponent(commonPath, isDirectory: false)
    }
    
    var version: Version {
        return .v1
    }
    
    var service: String {
        return ""
    }
    
    var query: Parameters? {
        return nil
    }
    
    var body: Parameters? {
        return nil
    }
    
    var multipartFormData: [MultipartFormData]? {
        return nil
    }
}
