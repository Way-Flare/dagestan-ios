//
//  DemoCheckingDKButton.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

enum WrappedType: String, Identifiable {
    case primary = "Primary"
    case secondary = "Secondary"
    case ghost = "Ghost"
    case nature = "Nature"
    
    var id: UUID { UUID() }
    
    var type: DKButtonStyle {
        switch self {
            case .primary: return .primary
            case .secondary: return .secondary
            case .ghost: return .ghost
            case .nature: return .nature
        }
    }
}

enum DemoSize: String {
    case l, m, s, xs
    
    var buttonSize: DKButton.Size {
        switch self {
            case .l: return .l
            case .m: return .m
            case .s: return .s
            case .xs: return .xs
        }
    }
    
    var buttonIconSize: DKButtonIcon.Size {
        switch self {
            case .l: return .l
            case .m: return .m
            case .s: return .s
            case .xs: return .xs
        }
    }
}

enum ImagePosition: Hashable {
    case left, right
}

public struct ButtonExampleView: View {
    @State private var selectedStyleIndex = 0
    
    public let buttonType: ControlMenuItem
    private let sizes: [DemoSize] = [.l, .m, .s, .xs]
    private let states: [DKButtonState] = [.default, .hover, .active, .disabled]
    private let types: [WrappedType] = [.primary, .secondary, .ghost, .nature]
    private let image = Image(systemName: "target")
        
    public init(buttonType: ControlMenuItem = .button) {
        self.buttonType = buttonType
    }
    
    public var body: some View {
        ScrollView {
            Picker("Styles", selection: $selectedStyleIndex) {
                ForEach(types.indices, id: \.self) { index in
                    Text(self.types[index].rawValue).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            buttonsView
        }
    }
    
    private var imageConfigurations: [[ImagePosition]] {
        [[], [.left], [.right], [.left, .right]]
    }
    
    private var buttonsView: some View {
        let identifiable = types[selectedStyleIndex]
        return VStack(spacing: Grid.pt48) {
            ForEach(sizes, id: \.self) { size in
                VStack {
                    ForEach(states, id: \.self) { state in
                        infoView(
                            size: size,
                            style: identifiable,
                            state: state,
                            image: image
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func infoView(
        size: DemoSize,
        style: WrappedType,
        state: DKButtonState,
        image: Image? = nil
    ) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Size: \(size.rawValue)")
                Text("State: \(state.rawValue)")
            }
            
            Spacer()
            
            if buttonType == .button {
                DKButton(
                    title: "Label",
                    size: size.buttonSize,
                    state: state,
                    type: style.type,
                    leftImage: image,
                    rightImage: image
                ) {}
            } else {
                DKButtonIcon(
                    icon: image ?? Image(systemName: "target"),
                    size: size.buttonIconSize,
                    state: state,
                    type: style.type
                ) {}
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ButtonExampleView()
}
