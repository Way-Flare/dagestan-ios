//
//  DemoCheckingDKButton.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 25.04.2024.
//

import SwiftUI
import DTDesignSystem

struct ButtonExampleView: View {
    @StateObject var viewModel: ButtonExampleViewModel

    init(buttonType: ControlMenuItem = .button) {
        _viewModel = StateObject(wrappedValue: ButtonExampleViewModel(buttonType: buttonType))
    }

    var body: some View {
        ScrollView {
            Picker("Styles", selection: $viewModel.selectedType) {
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
                        infoView(size: size, type: $viewModel.selectedType, state: state)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func infoView(
        size: WrappedButtonSize,
        type: Binding<WrappedButtonType>,
        state: WrappedButtonState
    ) -> some View {
        let isSelected = viewModel.isSelected(size: size, state: state)
        return HStack {
            VStack(alignment: .leading) {
                Text("Size: \(size.rawValue)")
                Text("State: \(state.rawValue)")
            }
            
            Spacer()
            
            let currentImage = viewModel.currentImage(isSelected: isSelected)
            let currentState = viewModel.currentState(size: size, state: state)
            
            if viewModel.buttonType == .button {
                DTButton(
                    title: "Label",
                    size: size.buttonSize,
                    state: currentState,
                    type: type.wrappedValue.buttonType,
                    leftImage: currentImage,
                    rightImage: currentImage
                ) {
                    viewModel.toggleState(size: size, state: state)
                }
            } else {
                DTButtonIcon(
                    icon: currentImage,
                    size: size.buttonIconSize,
                    state: currentState,
                    type: type.wrappedValue.buttonType
                ) {
                    viewModel.toggleState(size: size, state: state)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MenuView<SwiftUIMenuItem, SwiftUIMenuRouter>()
}
