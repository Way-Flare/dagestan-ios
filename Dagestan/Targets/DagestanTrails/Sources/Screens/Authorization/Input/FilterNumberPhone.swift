//
//  FilterNumberPhone.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import Foundation

struct FilterNumberPhone {
    static func format(
        with mask: String = "+X (XXX)-XXX-XX-XX",
        phone: String
    ) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }

    static func extractNumbers(from phone: String) -> String {
        phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
}
