import Foundation
import Combine

public struct Client {
    public typealias ClientRequestCall<T: ClientEndpoint> = (T.Request) async throws -> T.Response

    public var convert: ClientRequestCall<ConvertEndpoint>
    public var currencies: ClientRequestCall<CurrenciesEndpoint>
    public var historical: ClientRequestCall<HistoricalEndpoint>
    public var historicalRange: ClientRequestCall<HistoricalRangeEndpoint>
    public var latest: ClientRequestCall<LatestEndpoint>
    public var status: ClientRequestCall<StatusEndpoint>

    public init(
        convert: @escaping ClientRequestCall<ConvertEndpoint>,
        currencies: @escaping ClientRequestCall<CurrenciesEndpoint>,
        historical: @escaping ClientRequestCall<HistoricalEndpoint>,
        historicalRange: @escaping ClientRequestCall<HistoricalRangeEndpoint>,
        latest: @escaping ClientRequestCall<LatestEndpoint>,
        status: @escaping ClientRequestCall<StatusEndpoint>
    ) {
        self.convert = convert
        self.currencies = currencies
        self.historical = historical
        self.historicalRange = historicalRange
        self.latest = latest
        self.status = status
    }
}
