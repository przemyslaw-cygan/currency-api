import Foundation
import CurrencyAPIData

public struct ConvertResponse: ClientResponse {
    public let meta: ResponseMeta
    public let data: [Currency.ID: ExchangeRate]

    public init(
        meta: ResponseMeta,
        data: [Currency.ID : ExchangeRate]
    ) {
        self.meta = meta
        self.data = data
    }
}
