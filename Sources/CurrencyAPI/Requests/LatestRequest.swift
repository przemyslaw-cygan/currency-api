import Foundation
import CurrencyAPIData

public struct LatestRequest: ClientRequest {
    public let baseCurrency: Currency.ID?
    public let currencies: [Currency.ID]?
    public let type: CurrencyType?

    public init(
        baseCurrency: Currency.ID? = nil,
        currencies: [Currency.ID]? = nil,
        type: CurrencyType? = nil
    ) {
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
