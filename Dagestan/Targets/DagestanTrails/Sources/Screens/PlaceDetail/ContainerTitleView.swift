//
//  ContainerTitleView.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 19.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ContainerTitleView<T: View>: View {
    let title: String?
    let content: () -> T
    
    init(
        title: String? = nil,
        content: @escaping () -> T
    ) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Grid.pt8) {
            titleView
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Grid.pt12)
        .background(WFColor.surfacePrimary)
        .cornerStyle(.constant(Grid.pt12))
    }
}

extension ContainerTitleView {
    @ViewBuilder private var titleView: some View {
        if let title {
            Text(title)
                .font(.manropeSemibold(size: Grid.pt18))
                .foregroundStyle(WFColor.foregroundPrimary)
        }
    }
}

#Preview {
    ZStack {
        Color.black
        ContainerTitleView(title: "Hello") {
            Text("Hello")
        }
    }
}
