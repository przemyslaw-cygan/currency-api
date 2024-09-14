import Foundation

public struct StatusResponse: Decodable, Hashable {
    public let accountId: Int
    public let quotas: [String: Quota]

    public init(
        accountId: Int,
        quotas: [String: Quota]
    ) {
        self.accountId = accountId
        self.quotas = quotas
    }
}
