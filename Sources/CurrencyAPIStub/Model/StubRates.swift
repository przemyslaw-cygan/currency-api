import Foundation
import CurrencyAPIData

public enum StubExchangeRates {
    public static let chfValues: [String: Double] = [
        "BTC": 0.0000198937,
        "CHF": 1,
        "CZK": 26.6501101345,
        "EGP": 57.213799399,
        "ETH": 0.0004672018,
        "EUR": 1.0647203616,
        "GBP": 0.8962709818,
        "HUF": 415.670403635,
        "JPY": 172.0376454424,
        "NOK": 12.4868615787,
        "PLN": 4.5499346721,
        "RON": 5.3005616662,
        "USD": 1.1767334755,
        "XAG": 0.0407755637,
        "XAU": 0.0004700635,
        "XPT": 0.0013114322,
    ]

    public static let usdValues: [String: Double] = [
        "BTC": 0.0000169059,
        "CHF": 0.8498101064,
        "CZK": 22.647532929,
        "EGP": 48.6208649548,
        "ETH": 0.0003970328,
        "EUR": 0.9048101238,
        "GBP": 0.7616601384,
        "HUF": 353.2409099404,
        "JPY": 146.1993297782,
        "NOK": 10.6114611668,
        "PLN": 3.8665804678,
        "RON": 4.5044708735,
        "USD": 1,
        "XAG": 0.0346514861,
        "XAU": 0.0003994647,
        "XPT": 0.0011144683,
    ]

    public static func exchangeRate(baseCurrencyID: Currency.ID, currencyID: Currency.ID) -> ExchangeRate? {
        let values = baseCurrencyID == "CHF" ? Self.usdValues : Self.chfValues

        guard
            let baseValue = values[baseCurrencyID],
            let currencyValue = values[currencyID]
        else { return nil }

        return ExchangeRate(
            code: currencyID,
            value: 1/baseValue * currencyValue
        )
    }
}