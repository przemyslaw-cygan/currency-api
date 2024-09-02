import Foundation
import CurrencyAPIData

public struct HistoricalRangeRequest: ClientRequest {
    public let dateStart: Date
    public let dateEnd: Date
    public let accuracy: RangeAccuracy?
    public let baseCurrency: Currency.ID?
    public let currencies: [Currency.ID]?
    public let type: CurrencyType?

    public init(
        dateStart: Date,
        dateEnd: Date,
        accuracy: RangeAccuracy? = nil,
        baseCurrency: Currency.ID? = nil,
        currencies: [Currency.ID]? = nil,
        type: CurrencyType? = nil
    ) {
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.accuracy = accuracy
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
