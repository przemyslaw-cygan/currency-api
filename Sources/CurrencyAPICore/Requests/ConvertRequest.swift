import Foundation

public struct ConvertRequest: Hashable {
    public let value: String
    public let date: Date?
    public let baseCurrency: String?
    public let currencies: [String]?
    public let type: CurrencyType?

    public init(
        value: String,
        date: Date? = nil,
        baseCurrency: String? = nil,
        currencies: [String]? = nil,
        type: CurrencyType? = nil
    ) {
        self.value = value
        self.date = date
        self.baseCurrency = baseCurrency
        self.currencies = currencies
        self.type = type
    }
}
