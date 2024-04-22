//
//  DKButton.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 20.04.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import DagestanKit

enum DKButtonState {
    case `default`
    case hover
    case active
    case disabled
}

protocol DKButtonStyle {
    var `default`: DKButtonAppearance { get }
    var hover: DKButtonAppearance { get }
    var active: DKButtonAppearance { get }
    var disabled: DKButtonAppearance { get }
}

protocol DKButtonAppearance {
    var foregroundColor: Color { get}
    var backgroundColor: Color { get}
}

struct DKButton: View {
    var title: String
    var size: Size
    var state: DKButtonState
    var style: DKButtonStyle
    var leftImage: String?
    var rightImage: String?
    
    init(
        title: String,
        size: Size,
        state: DKButtonState,
        style: DKButtonStyle,
        leftImage: String? = nil,
        rightImage: String? = nil
    ) {
        self.title = title
        self.size = size
        self.state = state
        self.style = style
        self.leftImage = leftImage
        self.rightImage = rightImage
    }

    var body: some View {
        Button(title) {}
            .foregroundStyle(stateStyle.foregroundColor)
            .frame(height: size.height)

            .padding(.horizontal, size.paddings.horizontal)
            .background(stateStyle.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
    }
}

extension DKButton {
    var stateStyle: DKButtonAppearance {
        switch state {
            case .default: style.default
            case .hover: style.hover
            case .active: style.active
            case .disabled: style.disabled
        }
    }
}

extension DKButton {
    enum Size {
        case l
        case m
        case s
        case xs
        
        var height: CGFloat {
            switch self {
                case .l: return Grid.pt52
                case .m: return Grid.pt44
                case .s: return Grid.pt36
                case .xs: return Grid.pt28
            }
        }
        
        var paddings: (vertical: CGFloat, horizontal: CGFloat) {
            switch self {
                case .l:  return (Grid.pt14, Grid.pt20)
                case .m, .s: return (Grid.pt10, Grid.pt20)
                case .xs: return (Grid.pt6, Grid.pt20)
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
                case .l, .m: return Grid.pt12
                case .s, .xs: return Grid.pt10
            }
        }
        
        var font: Font {
            switch self {
            case .l: break
                // Needs Implement
            case .m: break
                // Needs Implement
            case .s: break
                // Needs Implement
            case .xs: break
                // Needs Implement
            }
        }
    }
}

#Preview {
    DKButton(
        title: "Sodaad",
        size: .m,
        state: .active,
        style: .ghost
    )
}
