import Foundation
import Testing
@testable import CurrencyAPILive

@Suite struct FoundationExtensionsTests {
    @Test func arrayOfQueryItems() {
        var queryItems: [URLQueryItem] = []
        queryItems.append(name: "test1", value: nil)
        #expect(queryItems.isEmpty)
        queryItems.append(name: "test2", value: "test_value")
        queryItems.append(name: "test3", value: nil)
        #expect(queryItems.count == 1)
        #expect(queryItems.contains { $0.name == "test2" })
    }

    @Test func dateShortFormat() {
        let date = Date(timeIntervalSince1970: 1704153599)
        #expect(date.shortFormat == "2024-01-01")
    }

    @Test func dateLongFormat() {
        let date = Date(timeIntervalSince1970: 1704153599)
        #expect(date.longFormat == "2024-01-01T23:59:59Z")
    }
}
