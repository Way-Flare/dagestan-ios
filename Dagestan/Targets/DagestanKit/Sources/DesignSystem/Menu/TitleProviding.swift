//
//  TitleProviding.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public protocol TitleProviding: Identifiable {
    var title: String { get }
}

public extension TitleProviding where Self: RawRepresentable {
    var id: String { String(describing: self) }
}

public extension TitleProviding {
    var title: String {
        let name = String(describing: self)
        return name.prefix(1).capitalized + name.dropFirst()
    }
}

public enum SwiftUIMenuItem: Int, CaseIterable, TitleProviding {
    case control
}

public struct SwiftUIMenuRouter: MenuViewRouter {
    @ViewBuilder
    public static func route(item: SwiftUIMenuItem) -> some View {
        switch item {
            case .control: ControlMenuView()
        }
    }
}
