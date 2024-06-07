//
//  ButtonExampleViewModel.swift
//  DagestanKit
//
//  Created by Рассказов Глеб on 03.05.2024.
//

import SwiftUI
import DTDesignSystem

class ButtonExampleViewModel: ObservableObject {
    @Published var selectedType: ButtonExampleView.WrappedButtonType = .primary
    @Published var selectedStates: [String: Bool] = [:]

    let buttonType: ControlMenuItem
    let unselectedImage = Image(systemName: "target")
    let selectedImage = Image(systemName: "heart.fill")

    init(buttonType: ControlMenuItem) {
        self.buttonType = buttonType
    }

    func toggleState(size: ButtonExampleView.WrappedButtonSize, state: ButtonExampleView.WrappedButtonState) {
        let key = "\(size.rawValue)-\(state.rawValue)"
        selectedStates[key, default: false].toggle()
    }
    
    func isSelected(size: ButtonExampleView.WrappedButtonSize, state: ButtonExampleView.WrappedButtonState) -> Bool {
        selectedStates["\(size.rawValue)-\(state.rawValue)", default: false]
    }
    
    func currentState(size: ButtonExampleView.WrappedButtonSize, state: ButtonExampleView.WrappedButtonState) -> DTButtonState {
        isSelected(size: size, state: state) ? ButtonExampleView.WrappedButtonState.active.buttonState : state.buttonState
    }
    
    func currentImage(isSelected: Bool) -> Image {
        isSelected ? selectedImage : unselectedImage
    }
}
