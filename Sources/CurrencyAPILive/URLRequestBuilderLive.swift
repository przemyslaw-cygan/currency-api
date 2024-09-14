import Foundation
import CurrencyAPICore

extension URLRequestBuilder {
    static let live: (String) -> Self = { apiKey in
        URLRequestBuilder(
            baseUrl: "https://api.currencyapi.com",
            encoder: .live,
            urlComponentsModifier: { _ in },
            urlRequestModifier: {
                $0.setValue(apiKey, forHTTPHeaderField: "apiKey")
            }
        )
    }
}

extension URLRequestBuilder.Request {
    static let liveConvert: (ConvertRequest) -> Self = { request in
        Self(
            method: .get,
            path: "/v3/convert",
            queryItems: {
                var queryItems: [URLQueryItem] = []
                queryItems.append(name: "value", value: request.value)
                queryItems.append(name: "date", value: request.date?.shortFormat)
                queryItems.append(name: "base_currency", value: request.baseCurrency)
                queryItems.append(name: "currencies", value: request.currencies?.joined(separator: ","))
                queryItems.append(name: "type", value: request.type?.rawValue)
                return queryItems
            }()
        )
    }

    static let liveCurrencies: (CurrenciesRequest) -> Self = { request in
        Self(
            method: .get,
            path: "/v3/currencies",
            queryItems: {
                var queryItems: [URLQueryItem] = []
                queryItems.append(name: "currencies", value: request.currencies?.joined(separator: ","))
                queryItems.append(name: "type", value: request.type?.rawValue)
                return queryItems
            }()
        )
    }

    static let liveHistoricalRange: (HistoricalRangeRequest) -> Self = { request in
        Self(
            method: .get,
            path: "/v3/range",
            queryItems: {
                var queryItems: [URLQueryItem] = []
                queryItems.append(name: "datetime_start", value: request.dateRange.start.longFormat)
                queryItems.append(name: "datetime_end", value: request.dateRange.end.longFormat)
                queryItems.append(name: "accuracy", value: request.dateRange.accuracy.rawValue)
                queryItems.append(name: "base_currency", value: request.baseCurrency)
                queryItems.append(name: "currencies", value: request.currencies?.joined(separator: ","))
                queryItems.append(name: "type", value: request.type?.rawValue)
                return queryItems
            }()
        )
    }


    static let liveHistorical: (HistoricalRequest) -> Self = { request in
        Self(
            method: .get,
            path: "/v3/historical",
            queryItems: {
                var queryItems: [URLQueryItem] = []
                queryItems.append(name: "date", value: request.date.shortFormat)
                queryItems.append(name: "base_currency", value: request.baseCurrency)
                queryItems.append(name: "currencies", value: request.currencies?.joined(separator: ","))
                queryItems.append(name: "type", value: request.type?.rawValue)
                return queryItems
            }()
        )
    }

    static let liveLatest: (LatestRequest) -> Self = { request in
        Self(
            method: .get,
            path: "/v3/latest",
            queryItems: {
                var queryItems: [URLQueryItem] = []
                queryItems.append(name: "base_currency", value: request.baseCurrency)
                queryItems.append(name: "currencies", value: request.currencies?.joined(separator: ","))
                queryItems.append(name: "type", value: request.type?.rawValue)
                return queryItems
            }()
        )
    }

    static let liveStatus: (StatusRequest) -> Self = { request in
        Self(
            method: .get,
            path: "/v3/status"
        )
    }
}
