//
//  SectionsMenuView.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public typealias MenuItem = TitleProviding & CaseIterable & RawRepresentable

public protocol MenuViewRouter {
    associatedtype CaseItem
    associatedtype RoutedView: View

    @ViewBuilder
    static func route(item: CaseItem) -> RoutedView
}
