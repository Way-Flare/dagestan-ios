//
//  File.swift
//  
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public struct WFAvatarPlaceholderContent: AvatarContent {
    public let size: AvatarSize
    
    public init(size: AvatarSize) {
        self.size = size
    }
    
    public func contentView() -> some View {
        ZStack {
            Circle()
                .fill(Color.random)
                .frame(width: size.value, height: size.value)
        }
    }
}
