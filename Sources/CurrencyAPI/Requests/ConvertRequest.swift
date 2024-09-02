import Foundation
import CurrencyAPIData

public struct ConvertRequest: ClientRequest {
    public let value: String
    public let date: Date?
    public let baseCurrency: Currency.ID?
    public let currencies: [Currency.ID]?
    public let type: CurrencyType?

    public init(
        value: String,
        date: Date? = nil,
        baseCurrency: Currency.ID? = nil,
        currencies: [Currency.ID]? = nil,
        type: CurrencyType? = nil
    ) {
        self.value = value
        self.date = date
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
