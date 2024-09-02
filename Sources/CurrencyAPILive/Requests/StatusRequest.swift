import Foundation
import CurrencyAPI

extension StatusRequest: ClientLiveRequest {
    var method: String.RequestMethod {
        .get
    }

    var path: String {
        "/v3/status"
    }

    var headers: [String : String]? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var body: (any Encodable)? {
        nil
    }
}
