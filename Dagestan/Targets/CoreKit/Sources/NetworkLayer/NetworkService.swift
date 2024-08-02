//
//  NetworkService.swift
//  CoreKit
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//

import Foundation
import Security

public protocol INetworkService: AnyObject {
    func execute<T: Decodable>(
        _ endpoint: ApiEndpoint,
        expecting type: T.Type
    ) async throws -> T

    func execute<T: Decodable>(
        _ request: URLRequest,
        expecting type: T.Type
    ) async throws -> T

    func execute(_ endpoint: ApiEndpoint) async throws -> Int
}

public final class DTNetworkService: INetworkService {
    private var boundary: String

    public init() {
        self.boundary = "Boundary-\(UUID().uuidString)"
    }

    public func execute<T: Decodable>(
        _ request: URLRequest,
        expecting type: T.Type
    ) async throws -> T {
        return try await load(request, expecting: type)
    }

    public func execute<T: Decodable>(
        _ endpoint: ApiEndpoint,
        expecting type: T.Type
    ) async throws -> T {
        guard let urlRequest = self.request(from: endpoint) else {
            throw RequestError.invalidURL
        }

        return try await load(urlRequest, expecting: type)
    }

    public func execute(_ endpoint: ApiEndpoint) async throws -> Int {
        guard let urlRequest = self.request(from: endpoint) else {
            throw RequestError.invalidURL
        }

        let (_, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.noResponse
        }

        return httpResponse.statusCode
    }

    // MARK: - Private methods

    private func load<T: Decodable>(_ request: URLRequest, expecting type: T.Type) async throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            return try await handleResponse(statusCode: httpResponse.statusCode, data: data, decoder: decoder, expecting: type)
        } catch let error as RequestError {
            throw error
        } catch {
            throw RequestError.unknown
        }
    }

    private func request(from endpoint: ApiEndpoint) -> URLRequest? {
        var urlRequest = URLRequest(url: endpoint.url)

        if let query = endpoint.query,
           var urlComponents = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: false) {
            let queryItems: [URLQueryItem] = query.map {
                URLQueryItem(name: $0, value: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            }
            urlComponents.queryItems = queryItems
            urlRequest.url = urlComponents.url
        }

        if let multipartFormData = endpoint.multipartFormData {
            let boundary = "Boundary-\(UUID().uuidString)"
            urlRequest.httpBody = createMultipartBody(with: multipartFormData, boundary: boundary)
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        } else if let body = endpoint.body {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                print("Failed to serialize JSON: \(error.localizedDescription)")
            }
        } else {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // TODO: Constants.headers + enpoint.headers, когда добавим post запросы

        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        if let keychainData = KeychainService.load(key: ConstantAccess.accessTokenKey),
           let accessToken = String(data: keychainData, encoding: .utf8)
        {
            urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }

    private func createMultipartBody(with parts: [MultipartFormData], boundary: String) -> Data {
        var body = Data()

        for part in parts {
            let boundaryText = "--\(boundary)\r\n"
            body.append(boundaryText.data(using: .utf8)!)

            if let filename = part.fileName, let mimeType = part.mimeType {
                let contentDisposition = "Content-Disposition: form-data; name=\"\(part.name)\"; filename=\"\(filename)\"\r\n"
                let contentType = "Content-Type: \(mimeType)\r\n\r\n"
                body.append(contentDisposition.data(using: .utf8)!)
                body.append(contentType.data(using: .utf8)!)
            } else {
                let contentDisposition = "Content-Disposition: form-data; name=\"\(part.name)\"\r\n\r\n"
                body.append(contentDisposition.data(using: .utf8)!)
            }
            body.append(part.data)
            body.append("\r\n".data(using: .utf8)!)
        }

        let closingBoundary = "--\(boundary)--\r\n"
        body.append(closingBoundary.data(using: .utf8)!)

        return body
    }

    private func handleResponse<T: Decodable>(statusCode: Int, data: Data, decoder: JSONDecoder, expecting type: T.Type) async throws -> T {
        switch statusCode {
            case 200 ... 299:
                if data.isEmpty {
                    if T.self == EmptyResponse.self, let emptyResponse = EmptyResponse() as? T {
                        return emptyResponse
                    } else {
                        throw RequestError.emptyResponse
                    }
                }

                guard let decodedResponse = try? decoder.decode(type, from: data) else {
                    print("Ошибка декодирования")
                    throw RequestError.failedDecode
                }
                return decodedResponse
            case 401:
                guard let data = KeychainService.load(key: ConstantAccess.refreshTokenKey),
                      let refresh = String(data: data, encoding: .utf8)
                else {
                    throw RequestError.unauthorized
                }

                guard let accessTokenData = try await refreshToken(token: refresh).data(using: .utf8) else {
                    throw RequestError.unauthorized
                }
                let _ = KeychainService.save(key: ConstantAccess.accessTokenKey, data: accessTokenData)
                throw RequestError.unauthorized
            default:
                guard let decodedError = try? decoder.decode(ServerError.self, from: data) else {
                    throw RequestError.unexpectedStatusCode
                }
                throw RequestError.serverError(decodedError)
        }
    }

    /// Функция принимает токен обновления и пытается получить новый токен доступа с использованием указанного конечного точка API для обновления токена.
    /// В случае успеха возвращает новый токен доступа. В случае неудачи выбрасывает ошибку.
    ///
    /// - Parameter token: Токен обновления, используемый для запроса нового токена доступа.
    /// - Returns: Строка, представляющая новый токен доступа.
    /// - Throws: Ошибка типа `Error`, указывающая причины сбоя, такие как проблемы с сетью,
    ///           ошибки декодирования или недействительные токены.
    func refreshToken(token: String) async throws -> String {
        let endpoint = RefreshTokenEndpoint.refreshToken(token: token)
        do {
            let token = try await execute(endpoint, expecting: String.self)
            return token
        } catch {
            throw error
        }
    }
}

public enum ConstantAccess {
    public static let accessTokenKey = "ACCESS_TOKEN_KEY"
    public static let refreshTokenKey = "REFRESH_TOKEN_KEY"
}
