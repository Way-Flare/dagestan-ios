//
//  RefreshTokenEndpoint.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 21.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

public enum RefreshTokenEndpoint {
    case refreshToken(token: String)
}

extension RefreshTokenEndpoint: ApiEndpoint {
    public var path: String {
        switch self {
            case .refreshToken:
                return "auth/refresh-token/"
        }
    }

    public var method: CoreKit.Method {
        return .post
    }

    public var headers: Headers? {
        [
            "Content-Type": "application/json",
            "X-CSRFTOKEN": "1HjjnFKBPN8VN9QqntupPv85BCsufwRsAyUnvd91d06fNvm1FmAtailNqaecQCsb"
        ]
    }

    public var body: Parameters? {
        guard case let .refreshToken(token) = self else { return nil }
        return ["access": token]
    }
}
