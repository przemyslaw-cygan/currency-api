import Foundation

public struct CurrenciesRequest: Hashable {
    public let currencies: [String]?
    public let type: CurrencyType?

    public init(
        currencies: [String]? = nil,
        type: CurrencyType? = nil
    ) {
        self.currencies = currencies
        self.type = type
    }
}
