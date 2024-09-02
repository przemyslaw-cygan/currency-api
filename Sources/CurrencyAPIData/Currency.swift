import Foundation

public struct Currency: Codable, Hashable, Sendable, Identifiable {
    public var id: String { self.code }

    public let symbol: String
    public let name: String
    public let symbolNative: String
    public let decimalDigits: Int
    public let rounding: Int
    public let code: String
    public let namePlural: String
    public let type: CurrencyType
    public let countries: [String]

    public init(
        symbol: String,
        name: String,
        symbolNative: String,
        decimalDigits: Int,
        rounding: Int,
        code: String,
        namePlural: String,
        type: CurrencyType,
        countries: [String]
    ) {
        self.symbol = symbol
        self.name = name
        self.symbolNative = symbolNative
        self.decimalDigits = decimalDigits
        self.rounding = rounding
        self.code = code
        self.namePlural = namePlural
        self.type = type
        self.countries = countries
    }
}
