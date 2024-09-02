import Foundation

public enum CurrencyType: String, Codable, Hashable, Sendable {
    case fiat
    case metal
    case crypto
}
