import Foundation
import Overture
import CurrencyAPI
import CurrencyAPIData

extension Client {
    public static func stub(lastUpdatedAt: Date = Date(timeIntervalSince1970: 0)) -> Self {
        let inteval: (RangeAccuracy?) -> TimeInterval = {
            switch $0 {
            case .day:
                60 * 60 * 24
            case .hour:
                60 * 60
            case .minute:
                60
            case .quarterHour:
                60 * 15
            case .none:
                60 * 60 * 24
            }
        }

        let dates: (HistoricalRangeRequest) -> [Date] = { request in
            var dates: [Date] = []
            var start = request.dateStart
            while start <= request.dateEnd {
                dates.append(start)
                start.addTimeInterval(inteval(request.accuracy))
            }
            return dates
        }

        let dateMultiplier: (Date) -> (ExchangeRate) -> ExchangeRate = { date in { rate in
            let multiplier = rate.value == 1 ? 1 : 1 + 0.1 *  sin(3.14 * date.timeIntervalSince1970)
            return ExchangeRate(
                code: rate.code,
                value: multiplier * rate.value
            )
        }}

        let rate: (Currency.ID) -> (Currency.ID) -> ExchangeRate? = curry(StubExchangeRates.exchangeRate)

        func makeDictionary<T: Identifiable>(_ array: Array<T>) -> Dictionary<T.ID, T> {
            array.reduce(into: [:]) { $0[$1.id] = $1 }
        }

        struct Filters: Equatable {
            var currencies: [Currency.ID]?
            var type: CurrencyType?

            func match(_ item: Currency) -> Bool {
                (self.type == nil || item.type == self.type)
                && (self.currencies?.isEmpty != false || self.currencies!.contains(item.id))
            }
        }

        return .init(
            convert: { request in
                let value = (request.value as NSString).doubleValue
                let base = request.baseCurrency ?? "USD"
                let filters = Filters(
                    currencies: request.currencies,
                    type: request.type
                )

                let meta = ResponseMeta(lastUpdatedAt: lastUpdatedAt)
                let data = StubCurrencies.all
                    .filter(filters.match)
                    .map(\.code)
                    .compactMap(rate(base))
                    .map { rate in
                        ExchangeRate(
                            code: rate.code,
                            value: value * rate.value
                        )
                    }

                return ConvertResponse(
                    meta: meta,
                    data: makeDictionary(data)
                )
            },
            currencies: { request in
                let filters = Filters(
                    currencies: request.currencies,
                    type: request.type
                )

                let data = StubCurrencies.all.filter(filters.match)

                return CurrenciesResponse(
                    data: makeDictionary(data)
                )
            },
            historical: { request in
                let base = request.baseCurrency ?? "USD"
                let date = request.date
                let filters = Filters(
                    currencies: request.currencies,
                    type: request.type
                )

                let meta = ResponseMeta(lastUpdatedAt: lastUpdatedAt)
                let data = StubCurrencies.all
                    .filter(filters.match)
                    .map(\.code)
                    .compactMap(rate(base))
                    .map(dateMultiplier(date))

                return HistoricalResponse(
                    meta: meta,
                    data: makeDictionary(data)
                )
            },
            historicalRange: { request in
                let base = request.baseCurrency ?? "USD"
                let filters = Filters(
                    currencies: request.currencies,
                    type: request.type
                )

                let currencies = StubCurrencies.all
                    .filter(filters.match)
                    .map(\.code)

                let data = dates(request).map { date in
                    let rates = currencies
                        .compactMap(rate(base))
                        .map(dateMultiplier(date))

                    return RangeExchangeRates(
                        datetime: date,
                        currencies: makeDictionary(rates)
                    )
                }

                return HistoricalRangeResponse(
                    data: data
                )
            },
            latest: { request in
                let base = request.baseCurrency ?? "USD"
                let filters = Filters(
                    currencies: request.currencies,
                    type: request.type
                )

                let meta = ResponseMeta(lastUpdatedAt: lastUpdatedAt)
                let data = StubCurrencies.all
                    .filter(filters.match)
                    .map(\.code)
                    .compactMap(rate(base))

                return LatestResponse(
                    meta: meta,
                    data: makeDictionary(data)
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
