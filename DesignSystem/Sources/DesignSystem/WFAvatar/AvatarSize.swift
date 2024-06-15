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
    
    public var value: CGFloat {
        switch self {
            case .size16: return 16
            case .size24: return 24
            case .size28: return 28
            case .size32: return 32
            case .size36: return 36
            case .size40: return 40
            case .size44: return 44
            case .size48: return 48
            case .size56: return 56
            case .size64: return 64
            case .size72: return 72
            case .size80: return 80
            case .size88: return 88
            case .size96: return 96
        }
    }
    
    public var iconSize: CGFloat {
        switch self {
            case .size16: return 12
            case .size24, .size28: return 16
            case .size32: return 20
            case .size36, .size40, .size44: return 24
            case .size48, .size56, .size64: return 28
            case .size72, .size80, .size88, .size96: return 48
        }
    }
    
    public var placeholderIcon: Image {
        switch self {
            case .size16, .size24, .size28: return Image("person.fill")
            default: return Image("person")
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
        }
    }
}
