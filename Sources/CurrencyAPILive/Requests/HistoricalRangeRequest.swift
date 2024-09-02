import Foundation
import CurrencyAPI

extension HistoricalRangeRequest: ClientLiveRequest {
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
            .init(name: "datetime_start", value: self.dateStart.ISO8601Format(.short)),
            .init(name: "datetime_end", value: self.dateEnd.ISO8601Format(.short)),
        ]
        self.accuracy.ifSome { items.append(.init(name: "accuracy", value: $0.rawValue)) }
        self.baseCurrency.ifSome { items.append(.init(name: "base_currency", value: $0)) }
        self.currencies?.forEach { items.append(.init(name: "currencies[]", value: $0)) }
        self.type.ifSome { items.append(.init(name: "type", value: $0.rawValue)) }
        return items
    }

    var body: (any Encodable)? {
        nil
    }
}
