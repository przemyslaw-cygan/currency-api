import Foundation
import Testing
import CurrencyAPICore
@testable import CurrencyAPILive

@Suite struct HistoricalTests {
    let dateFormatter = ISO8601DateFormatter()
    let decoder = JSONDecoder.live
    let builder = URLRequestBuilder.live("__API_KEY__")

    @Test func buildBasicRequest() throws {
        let request = HistoricalRequest(
            date: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!
        )

        let urlRequest = try self.builder.build(.liveHistorical(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/historical?date=2022-01-01"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func buildFullRequest() throws {
        let request = HistoricalRequest(
            date: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!,
            baseCurrency: "CHF",
            currencies: ["USD", "EUR"],
            type: .fiat
        )

        let urlRequest = try self.builder.build(.liveHistorical(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/historical?date=2022-01-01&base_currency=CHF&currencies=USD,EUR&type=fiat"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func buildOddRequest() throws {
        let request = HistoricalRequest(
            date: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!,
            baseCurrency: "CHF",
            currencies: [],
            type: .none
        )

        let urlRequest = try self.builder.build(.liveHistorical(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/historical?date=2022-01-01&base_currency=CHF"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func decodeResponse() throws {
        let fixture = """
        {
            "meta": {
                "last_updated_at": "2022-01-01T23:59:59Z"
            },
            "data": {
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
        }
        """.data(using: .utf8)!

        let result = try self.decoder.decode(HistoricalResponse.self, from: fixture)
        let expectedResult = HistoricalResponse(
            meta: ResponseMeta(lastUpdatedAt: self.dateFormatter.date(from: "2022-01-01T23:59:59Z")!),
            data: [
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
        )

        #expect(result == expectedResult)
    }
}