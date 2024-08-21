//
//  AuthorizationViewModelV2.swift
//  DagestanTrails
//
//  Created by Gleb Rasskazov on 21.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import SwiftUI
import CoreKit

protocol IAuthorizationViewModelV2: ObservableObject {
    var path: NavigationPath { get set }
    var phoneNumber: String { get set }
    var code: String { get set }
    var confirmVerification: LoadingState<Void> { get }
    var loginState: LoadingState<Void> { get }

    func auth() async
    func sendSmsVerification() async
    func confirmSmsVerification() async
}

final class AuthorizationViewModelV2: IAuthorizationViewModelV2 {
    @Published var path = NavigationPath()
    @Published var loginState: LoadingState<Void> = .idle
    @Published var sendVerification: LoadingState<Void> = .idle
    @Published var confirmVerification: LoadingState<Void> = .idle
    @Published var phoneNumber: String = ""
    @Published var code = ""
    
    private var authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }
    
    @MainActor
    func auth() async {
        withAnimation { loginState = .loading }
        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let _ = try await authService.authV2(phone: phoneNumber)
            withAnimation { loginState = .loaded(()) }
        } catch let requestError as RequestError {
            withAnimation { loginState = .failed(requestError.message) }
        } catch {
            withAnimation { loginState = .failed("Произошла ошибка: \(error.localizedDescription)") }
        }
    }

    @MainActor
    func confirmSmsVerification() async {
        guard let code = Int(code) else { return }
        withAnimation { confirmVerification = .loading }
        
        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let token = try await authService.confirmVerificationSmsV2(phone: phoneNumber, code: code)
            KeychainService.handleToken(access: token.access, refresh: token.refresh)
            withAnimation { confirmVerification = .loaded(()) }
        } catch let requestError as RequestError {
            withAnimation { confirmVerification = .failed(requestError.message) }
        } catch {
            withAnimation { confirmVerification = .failed("Произошла ошибка: \(error.localizedDescription)") }
        }
    }

    @MainActor
    func sendSmsVerification() async {
        withAnimation { confirmVerification = .loading }
        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let _ = try await authService.registerSendVerificationSms(phone: phoneNumber)
            withAnimation { sendVerification = .loaded(()) }
        } catch let requestError as RequestError {
            withAnimation { sendVerification = .failed(requestError.message) }
        } catch {
            withAnimation { sendVerification = .failed("Произошла ошибка: \(error.localizedDescription)") }
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
