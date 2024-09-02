import Foundation
import CurrencyAPI

extension CurrenciesRequest: ClientLiveRequest {
    var method: String.RequestMethod {
        .get
    }

    var path: String {
        "/v3/currencies"
    }

    var headers: [String: String]? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        self.currencies?.forEach { items.append(.init(name: "currencies[]", value: $0)) }
        self.type.ifSome { items.append(.init(name: "type", value: $0.rawValue)) }
        return items
    }

    var body: Encodable? {
        nil
    }
}
