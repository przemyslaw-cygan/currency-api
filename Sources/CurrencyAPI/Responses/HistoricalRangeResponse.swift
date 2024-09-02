import Foundation
import CurrencyAPIData

public struct HistoricalRangeResponse: ClientResponse {
    public let data: [RangeExchangeRates]

    public init(data: [RangeExchangeRates]) {
        self.data = data
    }
}
