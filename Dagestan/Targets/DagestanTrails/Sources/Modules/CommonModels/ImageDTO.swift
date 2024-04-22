//
//  ImageDataItem.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 19.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public struct ImageDTO: Decodable {
    public let file: String
    public let name: String?
}
