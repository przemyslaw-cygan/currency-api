import Foundation

public struct HistoricalRangeResponse: Decodable, Hashable {
    public let data: [RangeExchangeRates]

    public init(data: [RangeExchangeRates]) {
        self.data = data
    }
}
