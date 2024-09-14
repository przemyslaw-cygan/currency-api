import Foundation

public struct CurrenciesResponse: Decodable, Hashable {
    public let data: [String: Currency]

    public init(data: [String: Currency]) {
        self.data = data
    }
}
