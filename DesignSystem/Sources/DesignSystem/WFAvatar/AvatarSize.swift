//
//  WFAvatarSize.swift
//
//
//  Created by Рассказов Глеб on 15.06.2024.
//

import SwiftUI

public enum AvatarSize {
    case size16
    case size24
    case size28
    case size32
    case size36
    case size40
    case size44
    case size48
    case size56
    case size64
    case size72
    case size80
    case size88
    case size96
    case size186
    
    public var value: CGFloat {
        switch self {
            case .size16: return Grid.pt16
            case .size24: return Grid.pt24
            case .size28: return Grid.pt28
            case .size32: return Grid.pt32
            case .size36: return Grid.pt36
            case .size40: return Grid.pt40
            case .size44: return Grid.pt44
            case .size48: return Grid.pt48
            case .size56: return Grid.pt56
            case .size64: return Grid.pt64
            case .size72: return Grid.pt72
            case .size80: return Grid.pt80
            case .size88: return Grid.pt88
            case .size96: return Grid.pt96
            case .size186: return Grid.pt186
        }
    }
    
    public var iconSize: CGFloat {
        switch self {
            case .size16: return Grid.pt12
            case .size24, .size28: return Grid.pt16
            case .size32: return Grid.pt20
            case .size36, .size40, .size44: return Grid.pt24
            case .size48, .size56, .size64: return Grid.pt28
            case .size72, .size80, .size88, .size96, .size186: return Grid.pt48
        }
    }
    
    public var placeholderIcon: Image {
        switch self {
            case .size16, .size24, .size28: return Image(systemName: "person.fill")
            default: return Image(systemName: "person")
        }
    }
    
    public var fontSize: CGFloat {
        switch self {
            case .size16: return 5
            case .size24: return 8
            case .size28, .size32: return 10
            case .size36: return 13
            case .size40, .size44: return 14
            case .size48: return 17
            case .size56: return 18
            case .size64: return 21
            case .size72, .size80: return 26
            case .size88, .size96: return 30
            case .size186: return 58
        }
    }
}
