//
//  File.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public protocol AvatarContent {
    associatedtype Content: View
    
    @ViewBuilder
    func contentView() -> Content
}
