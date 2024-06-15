//
//  WFSegmentedPickerView.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public struct WFSegmentedPickerView<T: Hashable & CaseIterable & CustomStringConvertible, Content: View>: View {
    @Binding var selection: T
    let content: (T) -> Content
    private let tabs = Array(T.allCases)
    
    public init(
        selection: Binding<T>,
        content: @escaping (T) -> Content
    ) {
        self._selection = selection
        self.content = content
    }

    public var body: some View {
        VStack(spacing: .zero) {
            VStack(spacing: Grid.pt4){
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            selection = tab
                        } label: {
                            Text(tab.description)
                                .foregroundColor(selection == tab ? WFColor.foregroundPrimary : WFColor.foregroundSoft)
                                .font(.manropeSemibold(size: Grid.pt16))
                                .frame(maxWidth: .infinity)
                        }
                    }
                }

                GeometryReader { geometry in
                    Rectangle()
                        .fill(WFColor.accentPrimary)
                        .frame(width: Grid.pt148, height: Grid.pt2)
                        .offset(x: calculateOffset(geometry: geometry), y: 0)
                        .animation(.easeInOut(duration: 0.2), value: selection)
                }
                .frame(height: Grid.pt3)
            }
            .padding(Grid.pt16)

            content(selection)
            Spacer()
        }
    }

    private func calculateOffset(geometry: GeometryProxy, fixedIndicatorWidth: CGFloat = Grid.pt148) -> CGFloat {
        let totalWidth = geometry.size.width
        let numberOfTabs = CGFloat(tabs.count)
        let indexedCases = tabs.enumerated()

        guard let selectedIndex = indexedCases.first(where: { $0.element == selection })?.offset else {
            return 0
        }

        let tabWidth = totalWidth / numberOfTabs
        let selectedTabCenter = CGFloat(selectedIndex) * tabWidth + tabWidth / 2
        let finalOffset = selectedTabCenter - fixedIndicatorWidth / 2

        return finalOffset
    }
}
