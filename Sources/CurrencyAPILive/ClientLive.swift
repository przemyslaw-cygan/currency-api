import Foundation
import Combine
import Overture
import CurrencyAPI

public extension Client {
    static func live(
        baseURL: String,
        apiKey: String,
        session: URLSession,
        urlComponentsModifier: @escaping (inout URLComponents) -> Void = { _ in },
        urlRequestModifier: @escaping (inout URLRequest) -> Void = { _ in }
    ) -> Self {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let build: (String, JSONEncoder) -> (ClientLiveRequest) throws -> URLRequest = { baseUrl, encoder in
            { request in
                guard var urlComponents = URLComponents(string: baseUrl) else {
                    throw URLError(.badURL)
                }

                urlComponents.path = request.path
                urlComponents.queryItems = request.queryItems
                urlComponentsModifier(&urlComponents)

                guard let url = urlComponents.url else {
                    throw URLError(.badURL)
                }

                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = request.method.rawValue
                urlRequest.allHTTPHeaderFields = request.headers
                urlRequestModifier(&urlRequest)

                if let body = request.body {
                    urlRequest.httpBody = try encoder.encode(body)
                }

                return urlRequest
            }
        }

        let intercept: (URLRequest) -> URLRequest = { urlRequest in
            update(urlRequest, concat(
                mver(\URLRequest.allHTTPHeaderFields) { $0 = $0 ?? [:] },
                { $0.allHTTPHeaderFields?["apiKey"] = apiKey }
            ))
        }

        let call: (any ClientLiveRequest) async throws -> (Data, URLResponse) = { request in
            try await session.data(for: with(request, pipe(
                build(baseURL, encoder),
                intercept
            )))
        }

        return .init(
            convert: { try decoder.decode(ConvertEndpoint.Response.self, from: try await call($0).0) },
            currencies: { try decoder.decode(CurrenciesEndpoint.Response.self, from: try await call($0).0) },
            historical: { try decoder.decode(HistoricalEndpoint.Response.self, from: try await call($0).0) },
            historicalRange: { try decoder.decode(HistoricalRangeEndpoint.Response.self, from: try await call($0).0) },
            latest: { try decoder.decode(LatestEndpoint.Response.self, from: try await call($0).0) },
            status: { try decoder.decode(StatusEndpoint.Response.self, from: try await call($0).0) }
        )
    }
}
