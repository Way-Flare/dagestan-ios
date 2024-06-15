//
//  WFAvatarImageContent.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public struct WFAvatarImageContent: AvatarContent {
    public let image: Image
    public let size: AvatarSize
    
    public init(image: Image, size: AvatarSize) {
        self.image = image
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
