import Foundation

public struct HistoricalRangeRequest: Hashable {
    public let dateRange: DateRange
    public let baseCurrency: String?
    public let currencies: [String]?
    public let type: CurrencyType?

    public init(
        dateRange: DateRange,
        baseCurrency: String?,
        currencies: [String]? = nil,
        type: CurrencyType? = nil
    ) {
        self.dateRange = dateRange
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}

