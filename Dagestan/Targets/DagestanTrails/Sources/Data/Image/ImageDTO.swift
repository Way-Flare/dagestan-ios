//
//  ImageDataItem.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//

import CoreKit
import Foundation

public struct ImageDTO: Decodable {
    public let name: String?
    public let file: String
    
    public var trimmedName: String? {
        guard let name = name else { return nil }
        let components = name.components(separatedBy: ":")
        return components.first
    }
    
    public var items: [String]? {
        guard let components = name?.components(separatedBy: ":"),
              components.count > 1 else {
            return nil
        }
        return Array(components.dropFirst())
    }
}

extension ImageDTO: Domainable {
    public func asDomain() -> URL? {
        return URL(string: file)
    }
}

extension ImageDTO: Identifiable {
    public var id: String { file }
}
