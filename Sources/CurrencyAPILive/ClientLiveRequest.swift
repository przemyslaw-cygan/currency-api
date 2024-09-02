import Foundation
import CurrencyAPI

protocol ClientLiveRequest {
    var method: String.RequestMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
}
