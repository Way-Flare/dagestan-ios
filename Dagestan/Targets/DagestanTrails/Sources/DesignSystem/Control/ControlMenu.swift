//
//  ControlMenu.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

public typealias ControlMenuView = MenuView<ControlMenuItem, ControlMenuRouter>

public enum ControlMenuItem: Int, CaseIterable, TitleProviding {
    case button
    case buttonIcon
}

public struct ControlMenuRouter: MenuViewRouter {
    @ViewBuilder
    public static func route(item: ControlMenuItem) -> some View {
        switch item {
            case .button, .buttonIcon: ButtonExampleView(buttonType: item)
        }
    }
}

#Preview {
    ControlMenuView()
}
