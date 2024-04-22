//
//  Domaninable.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

public protocol Domainable {
    associatedtype DomainType

    func asDomain() -> DomainType
}
