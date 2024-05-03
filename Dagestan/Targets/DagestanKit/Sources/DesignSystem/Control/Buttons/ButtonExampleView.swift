//
//  DemoCheckingDKButton.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI

public struct ButtonExampleView: View {
    @State private var selectedType: WrappedButtonType = .primary
    private let buttonType: ControlMenuItem
    private let image = Image(systemName: "target")
        
    public init(buttonType: ControlMenuItem = .button) {
        self.buttonType = buttonType
    }
    
    public var body: some View {
        ScrollView {
            Picker("Styles", selection: $selectedType) {
                ForEach(WrappedButtonType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            buttonsView
        }
    }
    
    private var buttonsView: some View {
        VStack(spacing: Grid.pt48) {
            ForEach(WrappedButtonSize.allCases, id: \.self) { size in
                VStack {
                    ForEach(WrappedButtonState.allCases, id: \.self) { state in
                        infoView(
                            size: size,
                            type: selectedType,
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
        size: WrappedButtonSize,
        type: WrappedButtonType,
        state: WrappedButtonState,
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
                    state: state.buttonState,
                    type: type.buttonType,
                    leftImage: image,
                    rightImage: image
                ) {}
            } else {
                DKButtonIcon(
                    icon: image ?? Image(systemName: "target"),
                    size: size.buttonIconSize,
                    state: state.buttonState,
                    type: type.buttonType
                ) {}
            }
        }
        .padding(.horizontal)
    }
}

extension ButtonExampleView {
    enum WrappedButtonType: String, CaseIterable {
        case primary = "Primary"
        case secondary = "Secondary"
        case ghost = "Ghost"
        case nature = "Nature"
        case overlay = "Overlay"
        case favorite = "Favorite"
            
        var buttonType: DKButtonStyle {
            switch self {
                case .primary: return .primary
                case .secondary: return .secondary
                case .ghost: return .ghost
                case .nature: return .nature
                case .overlay: return .overlay
                case .favorite: return .favorite
            }
        }
    }

    enum WrappedButtonSize: String, CaseIterable {
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
    
    enum WrappedButtonState: String, CaseIterable {
        case `default`
        case hover
        case active
        case disabled
        
        var buttonState: DKButtonState {
            switch self {
                case .default: return .default
                case .hover: return .hover
                case .active: return .active
                case .disabled: return .disabled
            }
        }
    }
}

#Preview {
    MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
}
