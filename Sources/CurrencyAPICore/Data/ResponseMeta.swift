import Foundation

public struct ResponseMeta: Codable, Hashable {
    public let lastUpdatedAt: Date

    public init(lastUpdatedAt: Date) {
        self.lastUpdatedAt = lastUpdatedAt
    }
}
