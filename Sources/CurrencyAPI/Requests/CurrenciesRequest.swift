import Foundation
import CurrencyAPIData

public struct CurrenciesRequest: ClientRequest {
    public let currencies: [Currency.ID]?
    public let type: CurrencyType?

    public init(
        currencies: [Currency.ID]? = nil,
        type: CurrencyType? = nil
    ) {
        self.currencies = currencies
        self.type = type
    }
}
