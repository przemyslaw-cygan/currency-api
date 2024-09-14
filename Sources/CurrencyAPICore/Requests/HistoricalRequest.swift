import Foundation

public struct HistoricalRequest: Hashable {
    public let date: Date
    public let baseCurrency: String?
    public let currencies: [String]?
    public let type: CurrencyType?

    public init(
        date: Date,
        baseCurrency: String? = nil,
        currencies: [String]? = nil,
        type: CurrencyType? = nil
    ) {
        self.date = date
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
