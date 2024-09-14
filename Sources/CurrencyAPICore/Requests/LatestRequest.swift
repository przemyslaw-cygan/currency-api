import Foundation

public struct LatestRequest: Hashable {
    public let baseCurrency: String?
    public let currencies: [String]?
    public let type: CurrencyType?

    public init(
        baseCurrency: String? = nil,
        currencies: [String]? = nil,
        type: CurrencyType? = nil
    ) {
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
