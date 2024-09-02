import Foundation
import CurrencyAPIData

public struct HistoricalRequest: ClientRequest {
    public let date: Date
    public let baseCurrency: Currency.ID?
    public let currencies: [Currency.ID]?
    public let type: CurrencyType?

    public init(
        date: Date,
        baseCurrency: Currency.ID? = nil,
        currencies: [Currency.ID]? = nil,
        type: CurrencyType? = nil
    ) {
        self.date = date
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
