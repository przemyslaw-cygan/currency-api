import Foundation

public struct Client {
    public typealias Endpoint<Request, Response> = (Request) async throws -> Response

    public var convert: Endpoint<ConvertRequest, ConvertResponse>
    public var currencies: Endpoint<CurrenciesRequest, CurrenciesResponse>
    public var historicalRange: Endpoint<HistoricalRangeRequest, HistoricalRangeResponse>
    public var historical: Endpoint<HistoricalRequest, HistoricalResponse>
    public var latest: Endpoint<LatestRequest, LatestResponse>
    public var status: Endpoint<StatusRequest, StatusResponse>

    public init(
        convert: @escaping Endpoint<ConvertRequest, ConvertResponse>,
        currencies: @escaping Endpoint<CurrenciesRequest, CurrenciesResponse>,
        historicalRange: @escaping Endpoint<HistoricalRangeRequest, HistoricalRangeResponse>,
        historical: @escaping Endpoint<HistoricalRequest, HistoricalResponse>,
        latest: @escaping Endpoint<LatestRequest, LatestResponse>,
        status: @escaping Endpoint<StatusRequest, StatusResponse>
    ) {
        self.convert = convert
        self.currencies = currencies
        self.historical = historical
        self.historicalRange = historicalRange
        self.latest = latest
        self.status = status
    }
}
