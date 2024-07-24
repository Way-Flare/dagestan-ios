//
//  AuthorizationViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit
import SwiftUI

protocol IAuthorizationViewModel: ObservableObject {
    var isAuthorized: Bool { get set }
    var path: NavigationPath { get set }
    var phoneNumber: String { get set }
    var password: String { get set }

    func login() async
}

class AuthStatus: ObservableObject {
    @Published var isAuthorized: Bool = false
}

final class AuthorizationViewModel: IAuthorizationViewModel {
    @Published var isAuthorized = false
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
    
    private var authService: AuthService
    private let keychainService: IKeychainService = KeychainService()
    private let authStatus: AuthStatus

    init(authService: AuthService, authStatus: AuthStatus) {
        self.authService = authService
        self.authStatus = authStatus
    }
    
    @MainActor
    func login() async {
        withAnimation { state = .loading }
        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let token = try await authService.login(phone: phoneNumber, password: password)
            handleTokenWithKeychain(with: token)
            withAnimation { state = .loaded(()) }
        } catch let requestError as RequestError {
            withAnimation { state = .failed(requestError.message) }
        } catch {
            withAnimation { state = .failed("Произошла ошибка: \(error.localizedDescription)") }
        }
    }
    
    private func handleTokenWithKeychain(with token: AuthToken) {
        if let accessData = token.access.data(using: .utf8),
           let refreshData = token.refresh.data(using: .utf8) {
            let accessStatus = keychainService.save(key: ConstantAccess.accessTokenKey, data: accessData)
            let refreshStatus = keychainService.save(key: ConstantAccess.refreshTokenKey, data: refreshData)
                        
            if accessStatus == noErr {
                print("Access token saved")
            } else {
                print("Access token not saved")
            }
            
            if refreshStatus == noErr {
                print("Refresh token saved")
            } else {
                print("Refresh token not saved")
            }
        }
    }
}
