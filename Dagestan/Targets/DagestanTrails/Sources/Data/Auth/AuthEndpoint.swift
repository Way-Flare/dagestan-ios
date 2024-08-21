//
//  AuthEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 08.06.2024.
//

import CoreKit

enum AuthEndpoint {
    /// Авторизация v2 по номеру телефона + смс, без пароля
    case authV2(phone: String)
    /// Подтверждения 4х значного кода для авторизации v2
    case confirmVerificationSmsV2(phone: String, code: Int)
    case login(phone: String, password: String)
    case refreshToken(token: String)
    case register(phone: String, password: String, repeated: String)
    case registerConfirmVerification(phone: String, code: Int)
    /// Отправить код по звонку для регистрации
    case registerSendVerification(phone: String)
    /// Отправить код по смс для регистрации (v1)
    case registerSendVerificationSms(phone: String)
    case resetPassword(phone: String, password: String, repeated: String)
    case resetPasswordConfirmVerification(phone: String, code: Int)
    case resetPasswordSendVerification(phone: String)
}

extension AuthEndpoint: ApiEndpoint {
    var path: String {
        switch self {
            case .login:
                return "auth/login/phone/"
            case .authV2:
                return "auth/login/phone/"
            case .refreshToken:
                return "auth/refresh-token/"
            case .register:
                return "auth/register/phone/"
            case .registerConfirmVerification:
                return "auth/register/phone/confirm-verification-code/"
            case .registerSendVerification:
                return "auth/register/phone/send-verification-code/"
            case .resetPassword:
                return "auth/reset-password/phone/"
            case .resetPasswordConfirmVerification:
                return "auth/reset-password/phone/confirm-verification-code/"
            case .resetPasswordSendVerification:
                return "auth/reset-password/phone/send-verification-code/"
            case .registerSendVerificationSms:
                return "auth/register/phone/sms/send-verif-code/"
            case .confirmVerificationSmsV2:
                return "auth/login/phone/confirm-verif-code"
        }
    }

    var method: CoreKit.Method {
        switch self {
            case .resetPassword: return .patch
            default: return .post
        }
    }

    var headers: Headers? {
        [
            "Content-Type": "application/json",
            "X-CSRFTOKEN": "1HjjnFKBPN8VN9QqntupPv85BCsufwRsAyUnvd91d06fNvm1FmAtailNqaecQCsb"
        ]
    }

    var version: Version {
        switch self {
            case .authV2, .confirmVerificationSmsV2: .v2
            default: .v1
        }
    }

    var body: Parameters? {
        var parameters: Parameters?

        switch self {
            case let .login(phone, password):
                parameters = [
                    "phone": phone,
                    "password": password
                ]
            case let .authV2(phone):
                parameters = [
                    "phone": phone
                ]
            case let .registerSendVerificationSms(phone):
                parameters = [
                    "phone": phone
                ]
            case let .confirmVerificationSmsV2(phone, code):
                parameters = [
                    "phone": phone,
                    "code": code
                ]
            case let .registerSendVerification(phone), let .resetPasswordSendVerification(phone):
                parameters = [
                    "phone": phone
                ]
            case let .registerConfirmVerification(phone, code), let .resetPasswordConfirmVerification(phone, code):
                parameters = [
                    "phone": phone,
                    "code": code
                ]
            case let .register(phone, password, repeated), let .resetPassword(phone, password, repeated):
                parameters = [
                    "phone": phone,
                    "password": password,
                    "repeat_password": repeated
                ]
            default:
                parameters = nil
        }

        return parameters
    }
}
