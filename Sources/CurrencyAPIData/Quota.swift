import Foundation

public struct Quota: Codable, Hashable, Sendable {
    public let total: Int
    public let used: Int
    public let remaining: Int

    public init(
        total: Int,
        used: Int,
        remaining: Int
    ) {
        self.total = total
        self.used = used
        self.remaining = remaining
    }
}
