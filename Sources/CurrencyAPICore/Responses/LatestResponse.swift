import Foundation

public struct LatestResponse: Decodable, Hashable {
    public let meta: ResponseMeta
    public let data: [String: ExchangeRate]

    public init(
        meta: ResponseMeta,
        data: [String: ExchangeRate]
    ) {
        self.meta = meta
        self.data = data
    }
}
