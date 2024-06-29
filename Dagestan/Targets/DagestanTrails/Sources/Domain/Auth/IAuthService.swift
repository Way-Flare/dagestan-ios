//
//  IAuthService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import Foundation

protocol IAuthService {
    func login(phone: String, password: String) async throws -> Bool
    func refreshToken(token: String) async -> Bool
    func register(phone: String, password: String, repeated: String) async throws -> Bool
    func registerConfirmVerification(phone: String, code: Int) async throws -> Bool
    func registerSendVerification(phone: String) async throws -> Bool
    func resetPassword(phone: String, password: String, repeated: String) async -> Bool
    func resetPasswordConfirmVerification(phone: String, code: Int) async -> Bool
    func resetPasswordSendVerification(phone: String) async -> Bool
}
