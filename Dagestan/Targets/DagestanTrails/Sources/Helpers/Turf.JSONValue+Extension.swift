//
//  Turf.JSONValue+Extension.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import MapboxMaps

extension Turf.JSONValue {
    var intValue: Int? {
        switch self {
            case let .number(num):
                return Int(num)
            default:
                return nil
        }
    }

    var stringValue: String? {
        switch self {
            case let .string(str):
                return str
            default:
                return nil
        }
    }
}
