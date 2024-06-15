//
//  WFAvatarView.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public struct EmptyAvatarContent: AvatarContent {
    public init() {}
    
    public func contentView() -> some View {
        EmptyView()
    }
}

public struct WFAvatarView<Content: AvatarContent>: View {
    let content: Content

    public init(content: Content) {
        self.content = content
    }
    
    public var body: some View {
        content.contentView()
    }
}

public extension WFAvatarView where Content == EmptyAvatarContent {
    static func placeholder(size: AvatarSize) -> WFAvatarView<WFAvatarPlaceholderContent> {
        WFAvatarView<WFAvatarPlaceholderContent>(content: WFAvatarPlaceholderContent(size: size))
    }

    static func image(_ image: Image, size: AvatarSize) -> WFAvatarView<WFAvatarImageContent> {
        WFAvatarView<WFAvatarImageContent>(content: WFAvatarImageContent(image: image, size: size))
    }

    static func initials(_ userName: String?, userId: String, size: AvatarSize) -> WFAvatarView<WFAvatarInitialsContent> {
        WFAvatarView<WFAvatarInitialsContent>(content: WFAvatarInitialsContent(userName: userName, userId: userId, size: size))
    }

    static func loading(size: AvatarSize) -> WFAvatarView<WFAvatarLoadingContent> {
        WFAvatarView<WFAvatarLoadingContent>(content: WFAvatarLoadingContent(size: size))
    }
}

 #Preview {
     WFAvatarView.initials("Gleb Rasskazov", userId: UUID().uuidString, size: .size44)
 }
