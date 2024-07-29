//
//  ScrollViewWithScrollOffset.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 25.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct ScrollViewWithScrollOffset<V: View>: View {
    @Binding var scrollOffset: CGFloat
    @ViewBuilder let content: V
    
    public init(scrollOffset: Binding<CGFloat>, content: () -> V) {
        _scrollOffset = scrollOffset
        self.content = content()
    }
    
    private let coordinateSpaceName = "scrollViewSpaceName"
    public var body: some View {
        ScrollView {
            content
                .background(
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named(coordinateSpaceName)).minY
                        Color.clear.preference(key: ScrollViewWithPullDownOffsetPreferenceKey.self, value: offset)
                    }
                )
        }
        .coordinateSpace(name: coordinateSpaceName)
        .onPreferenceChange(ScrollViewWithPullDownOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}

struct ScrollViewWithPullDownOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    ScrollViewWithScrollOffset(scrollOffset: .constant(0)) {
        VStack {
            DagestanTrailsAsset.profileBg.swiftUIImage
        }
    }
}
