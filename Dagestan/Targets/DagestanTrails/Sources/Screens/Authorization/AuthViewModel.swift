//
//  AuthorizationViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit
import SwiftUI

protocol IAuthorizationViewModel: ObservableObject {
    var path: NavigationPath { get set }
    var phoneNumber: String { get set }
    var password: String { get set }

    func login() async
}

final class AuthorizationViewModel: IAuthorizationViewModel {
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

    init(authService: AuthService) {
        self.authService = authService
    }
    
    @MainActor
    func login() async {
        withAnimation { state = .loading }
        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let token = try await authService.login(phone: phoneNumber, password: password)
            KeychainService.handleToken(access: token.access, refresh: token.refresh)
            withAnimation { state = .loaded(()) }
        } catch let requestError as RequestError {
            withAnimation { state = .failed(requestError.message) }
        } catch {
            withAnimation { state = .failed("Произошла ошибка: \(error.localizedDescription)") }
        }
    }
    
    private func handleTokenWithKeychain(using token: AuthToken) {
        if let accessData = token.access.data(using: .utf8),
           let refreshData = token.refresh.data(using: .utf8) {
            let accessStatus = KeychainService.save(key: ConstantAccess.accessTokenKey, data: accessData)
            let refreshStatus = KeychainService.save(key: ConstantAccess.refreshTokenKey, data: refreshData)
                        
            if accessStatus == noErr {
                print("Access token saved")
                UserDefaults.standard.setValue(true, forKey: "isAuthorized")
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
