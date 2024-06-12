//
//  AuthService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit

final class AuthService: IAuthService {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func login(phone: String, password: String) async throws -> Bool {
        let endpoint = AuthEndpoint.login(phone: phone, password: password)
        do {
            let token = try await networkService.execute(endpoint, expecting: String.self)
            print(token)
        } catch {
            throw error
        }
        return true
    }

    func refreshToken(token: String) async -> Bool {
        let _ = AuthEndpoint.refreshToken(token: token)
        return true
    }

    func register(phone: String, password: String, repeated: String) async -> Bool {
        let _ = AuthEndpoint.register(phone: phone, password: password, repeated: repeated)
        return true
    }

    func registerConfirmVerification(phone: String, code: Int) async -> Bool {
        let _ = AuthEndpoint.registerConfirmVerification(phone: phone, code: code)
        return true
    }

    func registerSendVerification(phone: String) async throws -> Bool {
        let endpoint = AuthEndpoint.registerSendVerification(phone: phone)
        do {
            let token = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
            print(token)
        } catch {
            throw error
        }
        return true
    }

    func resetPassword(phone: String, password: String, repeated: String) async -> Bool {
        let _ = AuthEndpoint.resetPassword(phone: phone, password: password, repeated: repeated)
        return true
    }

    func resetPasswordConfirmVerification(phone: String, code: Int) async -> Bool {
        let _ = AuthEndpoint.resetPasswordConfirmVerification(phone: phone, code: code)
        return true
    }

    func resetPasswordSendVerification(phone: String) async -> Bool {
        let _ = AuthEndpoint.resetPasswordSendVerification(phone: phone)
        return true
    }
}
