//
//  NetworkService.swift
//  CoreKit
//
//  Created by Abdulaev Ramazan on 13.04.2024.
//

import Foundation

public protocol NetworkServiceProtocol: AnyObject {
    func execute<T: Decodable>(
        _ endpoint: ApiEndpoint,
        expecting type: T.Type
    ) async throws -> T

    func execute<T: Decodable>(
        _ request: URLRequest,
        expecting type: T.Type
    ) async throws -> T
}

public final class DTNetworkService: NetworkServiceProtocol {
    public init() {}

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
            switch httpResponse.statusCode {
                case 200 ... 299:
                    if data.isEmpty {
                        if T.self == EmptyResponse.self,
                           let emptyResponse = EmptyResponse() as? T {
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
                default:
                    guard let decodedError = try? decoder.decode(ServerError.self, from: data) else {
                        throw RequestError.unexpectedStatusCode
                    }
                    throw RequestError.serverError(decodedError)
            }
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

        if let body = endpoint.body {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch {
                print(error.localizedDescription)
            }
        }

        // TODO: Constants.headers + enpoint.headers, когда добавим post запросы

        urlRequest.timeoutInterval = 5.0
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers

        return urlRequest
    }
}
