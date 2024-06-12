//
//  Domaninable.swift
//  CoreKit
//
//  Created by Рассказов Глеб on 22.04.2024.
//

import Foundation

/// Тип, на основе экземпляра которого можно создать экземпляр типа из Domain-слоя
public protocol Domainable {
    
    /// Тип из Domain-слоя, инициализируемый на основе содержимого
    /// экземпляра Self (типа, реализующего `Domainable`)
    associatedtype DomainType
    
    /// Возвращает экземпляр типа указанного в качестве DomainType при реализации Domainable
    /// с содержимым на основе содержимого self (объекта, у которого вызывается этот метод)
    func asDomain() -> DomainType
}
