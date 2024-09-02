import Foundation

public protocol ClientRequest: Hashable, Sendable {}
public protocol ClientResponse: Hashable, Decodable, Sendable {}

public protocol ClientEndpoint {
    associatedtype Request: ClientRequest
    associatedtype Response: ClientResponse
}

public struct ConvertEndpoint: ClientEndpoint {
    public typealias Request = ConvertRequest
    public typealias Response = ConvertResponse
}

public struct CurrenciesEndpoint: ClientEndpoint {
    public typealias Request = CurrenciesRequest
    public typealias Response = CurrenciesResponse
}

public struct HistoricalEndpoint: ClientEndpoint {
    public typealias Request = HistoricalRequest
    public typealias Response = HistoricalResponse
}

public struct HistoricalRangeEndpoint: ClientEndpoint {
    public typealias Request = HistoricalRangeRequest
    public typealias Response = HistoricalRangeResponse
}

public struct LatestEndpoint: ClientEndpoint {
    public typealias Request = LatestRequest
    public typealias Response = LatestResponse
}

public struct StatusEndpoint: ClientEndpoint {
    public typealias Request = StatusRequest
    public typealias Response = StatusResponse
}
