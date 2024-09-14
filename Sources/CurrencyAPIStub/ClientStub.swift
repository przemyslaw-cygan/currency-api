import Foundation
import CurrencyAPICore

public extension Client {
    /// default date: 2024-01-01
    static func stub(date: Date = Date(timeIntervalSince1970: 1704070800)) -> Client {
        Client(
            convert: { request in
                let value = (request.value as NSString).doubleValue
                let base = request.baseCurrency
                let currencies = Currency.Stub.filtered(request.currencies, request.type)

                return ConvertResponse(
                    meta: ResponseMeta(lastUpdatedAt: date),
                    data: currencies.reduce(into: [:]) {
                        $0[$1.code] = ExchangeRate.Stub.exchangeRate(
                            baseCurrencyCode: base,
                            currencyCode: $1.code,
                            date: date,
                            value: value
                        )
                    }
                )
            },
            currencies: { request in
                let currencies = Currency.Stub.filtered(request.currencies, request.type)

                return CurrenciesResponse(
                    data: currencies.reduce(into: [:]) {
                        $0[$1.code] = $1
                    }
                )
            },
            historicalRange: { request in
                let base = request.baseCurrency
                let dates = request.dateRange.dates
                let currencies = Currency.Stub.filtered(request.currencies, request.type)

                return HistoricalRangeResponse(
                    data: dates.map { date in
                        RangeExchangeRates(
                            datetime: date,
                            currencies: currencies.reduce(into: [:]) {
                                $0[$1.code] = ExchangeRate.Stub.exchangeRate(
                                    baseCurrencyCode: base,
                                    currencyCode: $1.code,
                                    date: date
                                )
                            }
                        )
                    }
                )
            },
            historical: { request in
                let base = request.baseCurrency
                let date = request.date
                let currencies = Currency.Stub.filtered(request.currencies, request.type)

                return HistoricalResponse(
                    meta: ResponseMeta(lastUpdatedAt: date),
                    data: currencies.reduce(into: [:]) {
                        $0[$1.code] = ExchangeRate.Stub.exchangeRate(
                            baseCurrencyCode: base,
                            currencyCode: $1.code,
                            date: date
                        )
                    }
                )
            },
            latest: { request in
                let base = request.baseCurrency
                let currencies = Currency.Stub.filtered(request.currencies, request.type)

                return LatestResponse(
                    meta: ResponseMeta(lastUpdatedAt: date),
                    data: currencies.reduce(into: [:]) {
                        $0[$1.code] = ExchangeRate.Stub.exchangeRate(
                            baseCurrencyCode: base,
                            currencyCode: $1.code,
                            date: date
                        )
                    }
                )
            },
            status: { _ in
                StatusResponse(
                    accountId: 0,
                    quotas: [:]
                )
            }
        )
    }
}

public extension Client {
    static func delayedCall<A, B>(
        _ endpoint: @escaping Endpoint<A, B>,
        delay: TimeInterval
    ) -> (A) async throws -> B { { a in
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        return try await endpoint(a)
    } }

    static func observedCall<A, B>(
        _ endpoint: @escaping Endpoint<A, B>,
        onRequest: @escaping (A) -> Void,
        onResponse: @escaping (B) -> Void,
        onError: @escaping (Error) -> Void
    ) -> (A) async throws -> B { { a in
        do {
            onRequest(a)
            let result = try await endpoint(a)
            onResponse(result)
            return result
        } catch {
            onError(error)
            throw error
        }
    } }
}
