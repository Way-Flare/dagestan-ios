//
//  RegisterViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//

import CoreKit
import SwiftUI

@MainActor
class RegisterViewModel: ObservableObject {
    private let authService: AuthService
    let isRecovery: Bool

    @Published var phoneNumber = "" {
        didSet {
            registrationState = .idle
        }
    }
    @Published var code = ""
    @Published var registrationState: LoadingState<Void> = .idle
    @Published var verificationState: LoadingState<Void> = .idle

    init(isRecovery: Bool = false, authService: AuthService) { // Временно
        self.authService = authService
        self.isRecovery = isRecovery
    }

    func performAuthRequest() async {
        withAnimation {
            registrationState = .loading
        }

        do {
            try await Task.sleep(nanoseconds: 750_000_000)
            let _ = try await !isRecovery
                              ? authService.registerSendVerification(phone: phoneNumber)
                              : authService.resetPasswordSendVerification(phone: phoneNumber)

            withAnimation {
                registrationState = .loaded(())
            }
        } catch let requestError as RequestError {
            withAnimation {
                registrationState = .failed(requestError.message)
            }
        } catch {
            withAnimation {
                registrationState = .failed("Произошла ошибка: \(error.localizedDescription)")
            }
        }
    }

    func performVerificationRequest() async {
        guard let code = Int(code) else { return }
        verificationState = .loading

        do {
            let _ = try await isRecovery
                              ? authService.registerConfirmVerification(phone: phoneNumber, code: code)
                              : authService.resetPasswordConfirmVerification(phone: phoneNumber, code: code)
            verificationState = .loaded(())
        } catch {
            verificationState = .failed("Произошла ошибка: \(error.localizedDescription)")
        }
    }
}
