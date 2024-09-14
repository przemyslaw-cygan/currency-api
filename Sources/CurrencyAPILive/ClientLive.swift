import Foundation
import CurrencyAPICore

public extension Client {
    static func live(
        apiKey: String,
        session: URLSession = .shared
    ) -> Client {
        let decoder = JSONDecoder.live
        let builder = URLRequestBuilder.live(apiKey)

        let fetchData: (URLRequestBuilder.Request) async throws -> Data = { source in
            try await session.data(for: builder.build(source)).0
        }

        return Client(
            convert: {
                try decoder.decode(
                    ConvertResponse.self,
                    from: try await fetchData(.liveConvert($0))
                )
            },
            currencies: {
                try decoder.decode(
                    CurrenciesResponse.self,
                    from: try await fetchData(.liveCurrencies($0))
                )
            },
            historicalRange: {
                try decoder.decode(
                    HistoricalRangeResponse.self,
                    from: try await fetchData(.liveHistoricalRange($0))
                )
            },
            historical: {
                try decoder.decode(
                    HistoricalResponse.self,
                    from: try await fetchData(.liveHistorical($0))
                )
            },
            latest: {
                try decoder.decode(
                    LatestResponse.self,
                    from: try await fetchData(.liveLatest($0))
                )
            },
            status: {
                try decoder.decode(
                    StatusResponse.self,
                    from: try await fetchData(.liveStatus($0))
                )
            }
        )
    }
}
