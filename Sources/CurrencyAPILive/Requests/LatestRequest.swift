import Foundation
import CurrencyAPI

extension LatestRequest: ClientLiveRequest {
    var method: String.RequestMethod {
        .get
    }

    var path: String {
        "/v3/latest"
    }

    var headers: [String : String]? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        baseCurrency.ifSome { items.append(.init(name: "base_currency", value: $0)) }
        currencies?.forEach { items.append(.init(name: "currencies[]", value: $0)) }
        type.ifSome { items.append(.init(name: "type", value: $0.rawValue)) }
        return items
    }

    var body: (any Encodable)? {
        nil
    }
}
