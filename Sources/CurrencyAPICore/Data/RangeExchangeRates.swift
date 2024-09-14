import Foundation

public struct RangeExchangeRates: Codable, Hashable {
    public let datetime: Date
    public let currencies: [String: ExchangeRate]

    public init(
        datetime: Date,
        currencies: [String: ExchangeRate]
    ) {
        self.datetime = datetime
        self.currencies = currencies
    }
}
