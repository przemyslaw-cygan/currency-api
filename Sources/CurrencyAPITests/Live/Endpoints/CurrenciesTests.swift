import Foundation
import Testing
import CurrencyAPICore
@testable import CurrencyAPILive

@Suite struct CurrenciesTests {
    let decoder = JSONDecoder.live
    let builder = URLRequestBuilder.live("__API_KEY__")

    @Test func buildBasicRequest() throws {
        let request = CurrenciesRequest()

        let urlRequest = try self.builder.build(.liveCurrencies(request))
        let expectedURLString = "https://api.currencyapi.com/v3/currencies"

        #expect(urlRequest.url?.absoluteString == expectedURLString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func buildFullRequest() throws {
        let request = CurrenciesRequest(
            currencies: ["USD", "EUR"],
            type: .fiat
        )

        let urlRequest = try self.builder.build(.liveCurrencies(request))
        let expectedURLString = "https://api.currencyapi.com/v3/currencies?currencies=USD,EUR&type=fiat"

        #expect(urlRequest.url?.absoluteString == expectedURLString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func buildOddRequest() throws {
        let request = CurrenciesRequest(
            currencies: [],
            type: .none
        )

        let urlRequest = try self.builder.build(.liveCurrencies(request))
        let expectedURLString = "https://api.currencyapi.com/v3/currencies"

        #expect(urlRequest.url?.absoluteString == expectedURLString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func decodeResponse() throws {
        let fixture = """
        {
            "data": {
                "AED": {
                    "symbol": "AED",
                    "name": "United Arab Emirates Dirham",
                    "symbol_native": "د.إ",
                    "decimal_digits": 2,
                    "rounding": 0,
                    "code": "AED",
                    "name_plural": "UAE dirhams",
                    "type": "fiat",
                    "countries": [
                        "AE"
                    ]
                },
                "AFN": {
                    "symbol": "Af",
                    "name": "Afghan Afghani",
                    "symbol_native": "؋",
                    "decimal_digits": 0,
                    "rounding": 0,
                    "code": "AFN",
                    "name_plural": "Afghan Afghanis",
                    "type": "fiat",
                    "countries": [
                        "AF"
                    ]
                },
            }
        }
        """.data(using: .utf8)!

        let result = try self.decoder.decode(CurrenciesResponse.self, from: fixture)
        let expectedResult = CurrenciesResponse(
            data: [
                "AED": Currency(
                    symbol: "AED",
                    name: "United Arab Emirates Dirham",
                    symbolNative: "د.إ",
                    decimalDigits: 2,
                    rounding: 0,
                    code: "AED",
                    namePlural: "UAE dirhams",
                    type: .fiat,
                    countries: [
                        "AE"
                    ]
                ),
                "AFN": Currency(
                    symbol: "Af",
                    name: "Afghan Afghani",
                    symbolNative: "؋",
                    decimalDigits: 0,
                    rounding: 0,
                    code: "AFN",
                    namePlural: "Afghan Afghanis",
                    type: .fiat,
                    countries: [
                        "AF"
                    ]
                ),
            ]
        )

        #expect(result == expectedResult)
    }
}
