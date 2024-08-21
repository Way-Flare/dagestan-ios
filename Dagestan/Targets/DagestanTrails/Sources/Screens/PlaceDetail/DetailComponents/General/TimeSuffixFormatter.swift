//
//  TimeSuffixFormatter.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 22.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct TimeSuffixFormatter {
    let workTime: String?
    
    var operatingStatus: OperatingStatus {
        guard let workTime else { return .unknown(value: "") }
        switch workTime.lowercased() {
            case "24/7", "Круглосуточно".lowercased():
                return .open24Hours
            default:
                if isValidTimeRange(workTime) {
                    return isOpenNow(workTime: workTime) ? .open(time: workTime) : .closed(time: workTime)
                } else {
                    return .unknown(value: workTime)
                }
        }
    }
    
    private func isValidTimeRange(_ workTime: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: "^\\d{2}:\\d{2} - \\d{2}:\\d{2}$") else { return false }
        let range = NSRange(location: 0, length: workTime.utf16.count)
        return regex.firstMatch(in: workTime, options: [], range: range) != nil
    }
    
    private func isOpenNow(workTime: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
            
        let times = workTime.split(separator: "-").map { String($0) }
        guard let openingTime = dateFormatter.date(from: times[0]),
              let closingTime = dateFormatter.date(from: times[1])
        else {
            return false
        }
            
        let currentTime = Date()
        let calendar = Calendar.current
            
        let openingComponents = calendar.dateComponents([.hour, .minute], from: openingTime)
        let closingComponents = calendar.dateComponents([.hour, .minute], from: closingTime)
            
        guard let openingDate = calendar.date(bySettingHour: openingComponents.hour!, minute: openingComponents.minute!, second: 0, of: currentTime),
              let closingDate = calendar.date(bySettingHour: closingComponents.hour!, minute: closingComponents.minute!, second: 0, of: currentTime)
        else {
            return false
        }
            
        if closingDate > openingDate {
            return currentTime >= openingDate && currentTime <= closingDate
        } else {
            return currentTime >= openingDate || currentTime <= closingDate
        }
    }
}

extension TimeSuffixFormatter {
    enum OperatingStatus {
        case open(time: String)
        case open24Hours
        case closed(time: String)
        case unknown(value: String)
        
        var description: String {
            switch self {
                case .open: return "Открыто"
                case .open24Hours: return "Открыто круглосуточно"
                case .closed: return "Закрыто"
                case .unknown(let value): return value
            }
        }
        
        var descriptionColor: Color {
            switch self {
                case .open, .open24Hours: return WFColor.successPrimary
                case .closed: return WFColor.errorPrimary
                case .unknown: return WFColor.foregroundSoft
            }
        }
        
        var suffix: String {
            switch self {
                case .open(let time), .closed(let time):
                    return " • до \(time)"
                default:
                    return ""
            }
        }
    }
}
