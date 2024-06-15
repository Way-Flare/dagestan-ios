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
                .foregroundColor(WFColor.iconDisabled)
                .frame(width: size.value, height: size.value)

            size.placeholderIcon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.iconSize, height: size.iconSize)
                .foregroundColor(WFColor.iconSoft)
        }
    }

}


#Preview {
    WFAvatarView.placeholder(size: .size48)
}
