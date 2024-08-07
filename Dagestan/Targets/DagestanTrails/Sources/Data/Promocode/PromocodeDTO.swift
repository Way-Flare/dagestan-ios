//
//  PromocodeDTO.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 07.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import CoreKit
import Foundation

struct PromocodeDTO: Decodable {
    let id: Int
    let value: String
    let expiryDate: String
}

extension PromocodeDTO: Domainable {
    func asDomain() -> Promocode {
        Promocode(
            id: id,
            value: value,
            expiryDate: formateDate()
        )
    }
    
    private func formateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: expiryDate) ?? Date()
        
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
}
