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
}

extension ImageDTO: Domainable {
    public func asDomain() -> URL? {
        return URL(string: file)
    }
}
