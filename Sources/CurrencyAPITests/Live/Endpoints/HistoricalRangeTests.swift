import Foundation
import Testing
import CurrencyAPICore
@testable import CurrencyAPILive

@Suite struct HistoricalRangeTests {
    let dateFormatter = ISO8601DateFormatter()
    let decoder = JSONDecoder.live
    let builder = URLRequestBuilder.live("__API_KEY__")

    @Test func buildBasicRequest() throws {
        let request = HistoricalRangeRequest(
            dateRange: DateRange(
                start: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!,
                end: self.dateFormatter.date(from: "2022-01-03T23:59:59Z")!,
                accuracy: .day
            )!,
            baseCurrency: "CHF"
        )

        let urlRequest = try self.builder.build(.liveHistoricalRange(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/range?datetime_start=2022-01-01T23:59:59Z&datetime_end=2022-01-03T23:59:59Z&accuracy=day&base_currency=CHF"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func buildFullRequest() throws {
        let request = HistoricalRangeRequest(
            dateRange: DateRange(
                start: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!,
                end: self.dateFormatter.date(from: "2022-01-03T23:59:59Z")!,
                accuracy: .day
            )!,
            baseCurrency: "CHF",
            currencies: ["USD", "EUR"],
            type: .fiat
        )

        let urlRequest = try self.builder.build(.liveHistoricalRange(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/range?datetime_start=2022-01-01T23:59:59Z&datetime_end=2022-01-03T23:59:59Z&accuracy=day&base_currency=CHF&currencies=USD,EUR&type=fiat"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func buildOddRequest() throws {
        let request = HistoricalRangeRequest(
            dateRange: DateRange(
                start: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!,
                end: self.dateFormatter.date(from: "2022-01-03T23:59:59Z")!,
                accuracy: .day
            )!,
            baseCurrency: "CHF",
            currencies: [],
            type: .none
        )

        let urlRequest = try self.builder.build(.liveHistoricalRange(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/range?datetime_start=2022-01-01T23:59:59Z&datetime_end=2022-01-03T23:59:59Z&accuracy=day&base_currency=CHF"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func decodeResponse() throws {
        let fixture = """
        {
            "data": [
                {
                    "datetime": "2022-01-01T23:59:59Z",
                    "currencies": {
                        "AED": {
                            "code": "AED",
                            "value": 3.67306
                        },
                        "AFN": {
                            "code": "AFN",
                            "value": 91.80254
                        },
                        "ALL": {
                            "code": "ALL",
                            "value": 108.22904
                        },
                        "AMD": {
                            "code": "AMD",
                            "value": 480.41659
                        }
                    }
                },
                {
                    "datetime": "2022-01-02T23:59:59Z",
                    "currencies": {
                        "AED": {
                            "code": "AED",
                            "value": 3.87306
                        },
                        "AFN": {
                            "code": "AFN",
                            "value": 91.80251
                        },
                        "ALL": {
                            "code": "ALL",
                            "value": 108.21904
                        },
                        "AMD": {
                            "code": "AMD",
                            "value": 480.41665
                        }
                    }
                },
                {
                    "datetime": "2022-01-03T23:59:59Z",
                    "currencies": {
                        "AED": {
                            "code": "AED",
                            "value": 4.0001
                        },
                        "AFN": {
                            "code": "AFN",
                            "value": 91.81254
                        },
                        "ALL": {
                            "code": "ALL",
                            "value": 118.22904
                        },
                        "AMD": {
                            "code": "AMD",
                            "value": 481.41659
                        }
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        let result = try self.decoder.decode(HistoricalRangeResponse.self, from: fixture)
        let expectedResult = HistoricalRangeResponse(data: [
            RangeExchangeRates(
                datetime: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!,
                currencies: [
                    "AED": ExchangeRate(
                        code: "AED",
                        value: 3.67306
                    ),
                    "AFN": ExchangeRate(
                        code: "AFN",
                        value: 91.80254
                    ),
                    "ALL": ExchangeRate(
                        code: "ALL",
                        value: 108.22904
                    ),
                    "AMD": ExchangeRate(
                        code: "AMD",
                        value: 480.41659
                    )
                ]
            ),
            RangeExchangeRates(
                datetime: self.dateFormatter.date(from: "2022-01-02T23:59:59Z")!,
                currencies: [
                    "AED": ExchangeRate(
                        code: "AED",
                        value: 3.87306
                    ),
                    "AFN": ExchangeRate(
                        code: "AFN",
                        value: 91.80251
                    ),
                    "ALL": ExchangeRate(
                        code: "ALL",
                        value: 108.21904
                    ),
                    "AMD": ExchangeRate(
                        code: "AMD",
                        value: 480.41665
                    )
                ]
            ),
            RangeExchangeRates(
                datetime: self.dateFormatter.date(from: "2022-01-03T23:59:59Z")!,
                currencies: [
                    "AED": ExchangeRate(
                        code: "AED",
                        value: 4.0001
                    ),
                    "AFN": ExchangeRate(
                        code: "AFN",
                        value: 91.81254
                    ),
                    "ALL": ExchangeRate(
                        code: "ALL",
                        value: 118.22904
                    ),
                    "AMD": ExchangeRate(
                        code: "AMD",
                        value: 481.41659
                    )
                ]
            ),
        ])

        #expect(result == expectedResult)
    }
}
