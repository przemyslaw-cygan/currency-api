import Foundation
import CurrencyAPIData

public struct StatusResponse: ClientResponse {
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
