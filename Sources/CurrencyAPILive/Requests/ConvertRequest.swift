import Foundation
import CurrencyAPI

extension ConvertRequest: ClientLiveRequest {
    var method: String.RequestMethod {
        .get
    }

    var path: String {
        "/v3/convert"
    }

    var headers: [String : String]? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = [
            .init(name: "value", value: self.value)
        ]
        self.date.ifSome { items.append(.init(name: "date", value: $0.ISO8601Format(.short))) }
        self.baseCurrency.ifSome { items.append(.init(name: "base_currency", value: $0)) }
        self.currencies?.forEach { items.append(.init(name: "currencies[]", value: $0)) }
        self.type.ifSome { items.append(.init(name: "type", value: $0.rawValue)) }
        return items
    }

    var body: (any Encodable)? {
        nil
    }
}
