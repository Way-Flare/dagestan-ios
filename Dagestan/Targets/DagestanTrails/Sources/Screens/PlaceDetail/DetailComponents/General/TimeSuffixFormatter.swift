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
    
    var operatingStatus: String {
        guard let workTime else { return "Время работы неизвестно" }
        return isOpenNow(workTime: workTime) ? "Открыто" : "Закрыто"
    }
    
    var operatingStatusColor: Color {
        guard let workTime else { return WFColor.foregroundSoft }
        return isOpenNow(workTime: workTime) ? WFColor.successPrimary : WFColor.errorPrimary
    }
    
    var operatingStatusSuffix: String {
        guard let workTime else { return "" }
        
        let times = workTime.split(separator: "-").map { String($0) }
        return " • до" + (isOpenNow(workTime: workTime) ? times[1] : times[0])
    }
    
    private func isOpenNow(workTime: String) -> Bool {
        // workTime имеет формат "HH:mm-HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let components = workTime.split(separator: "-").map { String($0) }
        guard components.count == 2,
              let openingTime = dateFormatter.date(from: components[0]),
              let closingTime = dateFormatter.date(from: components[1])
        else {
            return false
        }
        
        let currentTime = Date()
        let calendar = Calendar.current
        
        let openingComponents = calendar.dateComponents([.hour, .minute], from: openingTime)
        let closingComponents = calendar.dateComponents([.hour, .minute], from: closingTime)
        
        guard let openingHour = openingComponents.hour,
              let openingMinute = openingComponents.minute,
              let closingHour = closingComponents.hour,
              let closingMinute = closingComponents.minute,
              let openingDate = calendar.date(bySettingHour: openingHour, minute: openingMinute, second: 0, of: currentTime),
              let closingDate = calendar.date(bySettingHour: closingHour, minute: closingMinute, second: 0, of: currentTime)
        else {
            return false
        }
        
        return currentTime >= openingDate && currentTime <= closingDate
    }
}
