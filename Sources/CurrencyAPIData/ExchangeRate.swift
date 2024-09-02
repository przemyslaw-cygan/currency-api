import Foundation

public struct ExchangeRate: Codable, Hashable, Sendable, Identifiable {
    public var id: String { self.code }

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
