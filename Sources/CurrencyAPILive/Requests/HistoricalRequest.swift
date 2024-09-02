import Foundation
import CurrencyAPI

extension HistoricalRequest: ClientLiveRequest {
    var method: String.RequestMethod {
        .get
    }

    var path: String {
        "/v3/historical"
    }

    var headers: [String : String]? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = [
            .init(name: "date", value: self.date.ISO8601Format(.short)),
        ]
        self.baseCurrency.ifSome { items.append(.init(name: "base_currency", value: $0)) }
        self.currencies?.forEach { items.append(.init(name: "currencies[]", value: $0)) }
        self.type.ifSome { items.append(.init(name: "type", value: $0.rawValue)) }
        return items
    }

    var body: (any Encodable)? {
        nil
    }
}
