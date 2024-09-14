import Foundation

public struct ExchangeRate: Codable, Hashable {
    public let code: String
    public let value: Double

    public init(
        code: String,
        value: Double
    ) {
        self.code = code
        self.value = value
    }
}
