//
//  WFAvatarInitialsContent.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public struct WFAvatarInitialsContent: AvatarContent {
    public let userName: String?
    public let userId: String
    public let size: AvatarSize
    
    private var initials: String {
        guard let fullName = userName, !fullName.isEmpty else {
            return ""
        }
        let parts = fullName.split(separator: " ").map(String.init)

        if parts.count > 1 {
            if let firstInitial = parts.first?.first.map(String.init),
               let lastInitial = parts[1].first.map(String.init) {
                return firstInitial + lastInitial
            }
        } else if let singleName = parts.first, singleName.count > 1 {
            let index = singleName.index(singleName.startIndex, offsetBy: 2)
            return String(singleName[..<index]).uppercased()
        } else if let singleInitial = parts.first?.first.map(String.init) {
            return singleInitial
        }
        
        return ""
    }

    
    private var gradient: LinearGradient {
        let hashValue = userId.stableHash()
        let baseHue = Double(abs(hashValue) % 360) / 360.0
        let color1 = Color(hue: baseHue, saturation: 0.7, brightness: 0.9)
        let color2 = Color(hue: (baseHue + 0.1).truncatingRemainder(dividingBy: 1.0), saturation: 0.7, brightness: 0.9)
        return LinearGradient(colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    public init(
        userName: String?,
        userId: String,
        size: AvatarSize
    ) {
        self.userName = userName
        self.userId = userId
        self.size = size
    }
    
    public func contentView() -> some View {
        Text(initials)
            .foregroundColor(.white)
            .font(.manropeSemibold(size: size.fontSize))
            .frame(width: size.value, height: size.value)
            .background(gradient)
            .clipShape(Circle())
    }
}
