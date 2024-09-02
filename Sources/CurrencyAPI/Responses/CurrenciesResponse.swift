import Foundation
import CurrencyAPIData

public struct CurrenciesResponse: ClientResponse {
    public let data: [Currency.ID: Currency]

    public init(data: [Currency.ID: Currency]) {
        self.data = data
    }
}
