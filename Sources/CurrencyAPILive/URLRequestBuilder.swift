import Foundation

struct URLRequestBuilder {
    enum HTTPMethod: String {
        case connect = "CONNECT"
        case delete = "DELETE"
        case get = "GET"
        case head = "HEAD"
        case options = "OPTIONS"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
        case query = "QUERY"
        case trace = "TRACE"
    }

    struct Request {
        public var method: HTTPMethod
        public var path: String
        public var headers: [String: String]?
        public var queryItems: [URLQueryItem]?
        public var body: Encodable?

        init(
            method: HTTPMethod,
            path: String,
            headers: [String : String]? = nil,
            queryItems: [URLQueryItem]? = nil,
            body: Encodable? = nil
        ) {
            self.method = method
            self.path = path
            self.headers = headers
            self.queryItems = queryItems
            self.body = body
        }
    }

    var baseUrl: String
    var encoder: JSONEncoder
    var urlComponentsModifier: (inout URLComponents) -> Void
    var urlRequestModifier: (inout URLRequest) -> Void

    init(
        baseUrl: String,
        encoder: JSONEncoder,
        urlComponentsModifier: @escaping (inout URLComponents) -> Void = { _ in },
        urlRequestModifier: @escaping (inout URLRequest) -> Void = { _ in }
    ) {
        self.baseUrl = baseUrl
        self.encoder = encoder
        self.urlComponentsModifier = urlComponentsModifier
        self.urlRequestModifier = urlRequestModifier
    }

    func build(_ request: Request) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: self.baseUrl) else {
            throw URLError(.badURL)
        }

        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems
        self.urlComponentsModifier(&urlComponents)

        if urlComponents.queryItems?.isEmpty == true {
            urlComponents.queryItems = nil
        }

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        self.urlRequestModifier(&urlRequest)

        if urlRequest.allHTTPHeaderFields?.isEmpty == true {
            urlRequest.allHTTPHeaderFields = nil
        }

        if let body = request.body {
            urlRequest.httpBody = try self.encoder.encode(body)
        }

        return urlRequest
    }
}
