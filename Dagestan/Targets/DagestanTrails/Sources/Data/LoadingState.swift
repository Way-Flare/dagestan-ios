//
//  LoadingState.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 24.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)

    var data: T? {
        if case let .loaded(data) = self {
            return data
        }
        return nil
    }

    var error: Error? {
        if case let .failed(error) = self {
            return error
        }
        return nil
    }

    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
}
