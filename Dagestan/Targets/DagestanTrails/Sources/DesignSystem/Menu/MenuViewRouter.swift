//
//  SectionsMenuView.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI

public typealias MenuItem = TitleProviding & CaseIterable & RawRepresentable

/// Протокол `MenuViewRouter` описывает маршрутизацию для элементов меню на основе их типа.
/// Этот протокол предназначен для использования в системах навигации, где разные элементы меню
/// могут направлять пользователя на различные представления (`View`).
public protocol MenuViewRouter {
    /// Ассоциированный тип `CaseItem`, представляющий элементы меню.
    associatedtype CaseItem
    /// Ассоциированный тип `RoutedView`, представляющий представление, на которое будет выполнена навигация.
    associatedtype RoutedView: View

    /// Функция `route`, которая возвращает соответствующее представление для заданного элемента меню.
    /// Использует `@ViewBuilder` для построения представления, что позволяет интегрировать различные вью компоненты.
    @ViewBuilder
    static func route(item: CaseItem) -> RoutedView
}
