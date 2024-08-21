//
//  AuthService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit

final class AuthService: IAuthService {
    private let networkService: INetworkService

    init(networkService: INetworkService) {
        self.networkService = networkService
    }

    func login(phone: String, password: String) async throws -> AuthToken {
        let endpoint = AuthEndpoint.login(phone: phone, password: password)
        do {
            let token = try await networkService.execute(endpoint, expecting: AuthToken.self)
            return token
        } catch {
            throw error
        }
    }

    func refreshToken(token: String) async throws -> String {
        let endpoint = AuthEndpoint.refreshToken(token: token)
        do {
            let token = try await networkService.execute(endpoint, expecting: String.self)
            return token
        } catch {
            throw error
        }
    }

    func register(phone: String, password: String, repeated: String) async throws -> AuthToken {
        let endpoint = AuthEndpoint.register(phone: phone, password: password, repeated: repeated)
        do {
            let token = try await networkService.execute(endpoint, expecting: AuthToken.self)
            return token
        } catch {
            throw error
        }
    }

    func registerConfirmVerification(phone: String, code: Int) async throws {
        let endpoint = AuthEndpoint.registerConfirmVerification(phone: phone, code: code)
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }

    func registerSendVerification(phone: String) async throws {
        let endpoint = AuthEndpoint.registerSendVerification(phone: phone)
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }

    func resetPassword(phone: String, password: String, repeated: String) async throws -> String {
        let endpoint = AuthEndpoint.resetPassword(phone: phone, password: password, repeated: repeated)
        do {
            let token = try await networkService.execute(endpoint, expecting: String.self)
            return token
        } catch {
            throw error
        }
    }

    func resetPasswordConfirmVerification(phone: String, code: Int) async throws {
        let endpoint = AuthEndpoint.resetPasswordConfirmVerification(phone: phone, code: code)
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }

    func resetPasswordSendVerification(phone: String) async throws {
        let endpoint = AuthEndpoint.resetPasswordSendVerification(phone: phone)
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }
    
    func authV2(phone: String) async throws {
        let endpoint = AuthEndpoint.authV2(phone: phone)
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }

    func confirmVerificationSmsV2(phone: String, code: Int) async throws -> AuthToken {
        let endpoint = AuthEndpoint.confirmVerificationSmsV2(phone: phone, code: code)
        do {
            let token = try await networkService.execute(endpoint, expecting: AuthToken.self)
            return token
        } catch {
            throw error
        }
    }

    func registerSendVerificationSms(phone: String) async throws {
        let endpoint = AuthEndpoint.registerSendVerificationSms(phone: phone)
        do {
            let _ = try await networkService.execute(endpoint, expecting: EmptyResponse.self)
        } catch {
            throw error
        }
    }

}
