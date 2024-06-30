//
//  AuthorizationViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit
import SwiftUI

@MainActor
final class AuthorizationViewModel: ObservableObject {
    private let authService: AuthService

    @Published var path = NavigationPath()
    @Published var state: LoadingState<Void> = .idle
    @Published var phoneNumber = "" {
        didSet {
            withAnimation {
                state = oldValue != phoneNumber ? .idle : state
            }
        }
    }
    @Published var password = "" {
        didSet {
            withAnimation {
                state = oldValue != password ? .idle : state
            }
        }
    }

    init(authService: AuthService) {
        self.authService = authService
    }

    func login() async {
        withAnimation {
            state = .loading
        }
        
        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let _ = try await authService.login(phone: phoneNumber, password: password)
            withAnimation {
                state = .loaded(())
            }
        } catch let requestError as RequestError {
            withAnimation {
                state = .failed(requestError.message)
            }
        } catch {
            withAnimation {
                state = .failed("Произошла ошибка: \(error.localizedDescription)")
            }
        }
    }
}
