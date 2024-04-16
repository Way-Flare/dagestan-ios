//
//  ApiEndpoint.swift
//  DagestanTrails
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
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
}

public enum Method: String {
    case get
    case post
}

public enum Version: String {
    case v1
}

public extension ApiEndpoint {
    
    private var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        let url = URL(string: "http://51.250.105.67:8080")!

        return url
    }

    private var commonPath: String {
        return [service, version.rawValue, path].joined(separator: "/")
    }

    var url: URL {
        return baseURL.appendingPathComponent(commonPath, isDirectory: false)
    }

}
