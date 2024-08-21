//
//  IAuthService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import Foundation

protocol IAuthService {
    func login(phone: String, password: String) async throws -> AuthToken
    func refreshToken(token: String) async throws -> String
    func register(phone: String, password: String, repeated: String) async throws -> AuthToken
    func registerConfirmVerification(phone: String, code: Int) async throws
    func registerSendVerification(phone: String) async throws
    func registerSendVerificationSms(phone: String) async throws
    func resetPassword(phone: String, password: String, repeated: String) async throws -> String
    func resetPasswordConfirmVerification(phone: String, code: Int) async throws
    func resetPasswordSendVerification(phone: String) async throws
    /// Авторизация v2 без пароля по номеру телефону
    func authV2(phone: String) async throws
    /// Подтверждения 4х значного кода для авторизации v2
    func confirmVerificationSmsV2(phone: String, code: Int) async throws -> AuthToken
}
