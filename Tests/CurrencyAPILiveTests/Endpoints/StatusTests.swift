import Foundation
import Testing
import CurrencyAPICore
@testable import CurrencyAPILive

@Suite struct StatusTests {
    let decoder = JSONDecoder.live
    let builder = URLRequestBuilder.live("__API_KEY__")

    @Test func buildBasicRequest() throws {
        let request = StatusRequest()

        let urlRequest = try self.builder.build(.liveStatus(request))
        let expectedUrlString = "https://api.currencyapi.com/v3/status"

        #expect(urlRequest.url?.absoluteString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "apiKey") == "__API_KEY__")
    }

    @Test func decodeResponse() throws {
        let fixture = """
        {
          "account_id": 313373133731337,
          "quotas": {
            "month": {
              "total": 300,
              "used": 72,
              "remaining": 229
            },
            "grace": {
              "total": 0,
              "used": 0,
              "remaining": 0
            }
          }
        }
        """.data(using: .utf8)!

        let result = try self.decoder.decode(StatusResponse.self, from: fixture)
        let expectedResult = StatusResponse(
            accountId: 313373133731337,
            quotas: [
                "month": Quota(
                  total: 300,
                  used: 72,
                  remaining: 229
                ),
                "grace": Quota(
                  total: 0,
                  used: 0,
                  remaining: 0
                )
            ]
        )

        #expect(result == expectedResult)
    }
}
