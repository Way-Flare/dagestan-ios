//
//  IntrincsicHeightSheetModifier.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 08.09.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct IntrincsicHeightSheetModifier: ViewModifier {
    @State private var height: CGFloat = 0

    public func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                }
            }
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                height = newHeight
            }
            .presentationDetents([.height(height)])
    }
}

public extension View {
    func intrincsicHeightSheet() -> some View {
        modifier(IntrincsicHeightSheetModifier())
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
