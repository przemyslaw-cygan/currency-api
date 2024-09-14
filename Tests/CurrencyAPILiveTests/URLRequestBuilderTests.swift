import Foundation
import Testing
@testable import struct CurrencyAPILive.URLRequestBuilder

@Suite struct URLRequestBuilderTests {
    let builder = URLRequestBuilder(
        baseUrl: "https://example.com",
        encoder: {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601
            return encoder
        }()
    )

    @Test func buildPlain() throws {
        let source = URLRequestBuilder.Request(
            method: .get,
            path: "/123/some/path"
        )

        let urlString = try self.builder.build(source).url?.absoluteString
        let expectedString = "https://example.com/123/some/path"

        #expect(urlString == expectedString)
    }

    @Test func buildWithModifiers() throws {
        var customBuilder = self.builder

        customBuilder.urlComponentsModifier = {
            $0.queryItems = $0.queryItems ?? []
            $0.queryItems?.append(.init(name: "testItem", value: "TEST_ITEM_VALUE"))
        }

        customBuilder.urlRequestModifier = {
            $0.addValue("TEST_HEADER_VALUE", forHTTPHeaderField: "testHeader")
        }

        let source = URLRequestBuilder.Request(
            method: .get,
            path: "/123/some/path"
        )

        let urlRequest = try customBuilder.build(source)
        let urlString = urlRequest.url?.absoluteString
        let expectedUrlString = "https://example.com/123/some/path?testItem=TEST_ITEM_VALUE"

        #expect(urlString == expectedUrlString)
        #expect(urlRequest.value(forHTTPHeaderField: "testHeader") == "TEST_HEADER_VALUE")
    }

    @Test func buildWithQueryItems() throws {
        let source = URLRequestBuilder.Request(
            method: .get,
            path: "/123/some/path",
            queryItems: [
                .init(name: "plain_value", value: "value1"),
                .init(name: "dodgy_value", value: "value 2%+2"),
                .init(name: "last_value", value: "value3"),
            ]
        )

        let urlString = try self.builder.build(source).url?.absoluteString
        let expectedUrlString = "https://example.com/123/some/path?plain_value=value1&dodgy_value=value%202%25+2&last_value=value3"

        #expect(urlString == expectedUrlString)
    }

    @Test func buildWithQueryItemsAndModifiers() throws {
        var customBuilder = self.builder

        customBuilder.urlComponentsModifier = {
            $0.queryItems = $0.queryItems ?? []
            $0.queryItems?.append(.init(name: "testItem", value: "TEST_ITEM_VALUE"))
        }

        customBuilder.urlRequestModifier = {
            $0.addValue("TEST_HEADER_VALUE", forHTTPHeaderField: "testHeader")
        }

        let source = URLRequestBuilder.Request(
            method: .get,
            path: "/123/some/path",
            queryItems: [
                .init(name: "plain_value", value: "value1"),
                .init(name: "dodgy_value", value: "value 2%+"),
                .init(name: "last_value", value: "value3"),
            ]
        )

        let urlString = try customBuilder.build(source).url?.absoluteString
        let expectedUrlString = "https://example.com/123/some/path?plain_value=value1&dodgy_value=value%202%25+&last_value=value3&testItem=TEST_ITEM_VALUE"

        #expect(urlString == expectedUrlString)
    }

    @Test func buildOverridingHeaders() throws {
        var customBuilder = self.builder

        customBuilder.urlRequestModifier = {
            $0.addValue("Appended Header Value ///:::? 1234", forHTTPHeaderField: "Test Header")
            $0.setValue("Replaced Header Value", forHTTPHeaderField: "Other-Header")
        }

        let source = URLRequestBuilder.Request(
            method: .get,
            path: "/123/some/path",
            headers: [
                "Test Header": "some_header",
                "Other-Header": "123"
            ]
        )

        let urlRequest = try customBuilder.build(source)
        #expect(urlRequest.value(forHTTPHeaderField: "Test Header") == "some_header,Appended Header Value ///:::? 1234")
        #expect(urlRequest.value(forHTTPHeaderField: "Other-Header") == "Replaced Header Value")
    }
}
