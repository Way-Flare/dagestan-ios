//
//  MenuView.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

public struct MenuView<
    ItemType: MenuItem,
    Router: MenuViewRouter
>: View
    where
    ItemType.RawValue == Int,
    ItemType.AllCases.Index == Int,
    Router.CaseItem == ItemType {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(Array(ItemType.allCases)) { item in
                    NavigationLink {
                        Router.route(item: item)
                            .navigationTitle(item.title)
                    } label: {
                        Text(item.title)
                    }
                }
            }
        }
    }
}

#Preview {
    MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
}
