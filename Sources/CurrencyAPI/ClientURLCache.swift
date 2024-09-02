import Foundation

/**
 Allows to override `Cache-Control` from `URLRequest`

 ```swift
 var urlRequest: URLRequest
 urlRequest.addValue("max-age=1200", forHTTPHeaderField: CustomURLCache.customCacheControlHeaderField)
 ```
 */

open class ClientURLCache: URLCache {
    public static let customCacheControlHeaderField = "Custom-Cache-Control"
    public static let cacheControlHeaderField = "Cache-Control"

    public static let sharedInstance = ClientURLCache()

    override open func storeCachedResponse(_ cachedResponse: CachedURLResponse, for dataTask: URLSessionDataTask) {
        guard
            let customCacheControl = dataTask.originalRequest?.value(forHTTPHeaderField: Self.customCacheControlHeaderField),
            let httpResponse = cachedResponse.response as? HTTPURLResponse,
            let httpResponseURL = httpResponse.url
        else {
            super.storeCachedResponse(cachedResponse, for: dataTask)
            return
        }

        var headerFields = httpResponse.allHeaderFields as? [String: String] ?? [:]
        headerFields[Self.cacheControlHeaderField] = customCacheControl

        let newResponse = HTTPURLResponse(
            url: httpResponseURL,
            statusCode: httpResponse.statusCode,
            httpVersion: nil,
            headerFields: headerFields
        )

        guard let newResponse else {
            super.storeCachedResponse(cachedResponse, for: dataTask)
            return
        }

        let newCachedResponse = CachedURLResponse(
            response: newResponse,
            data: cachedResponse.data,
            userInfo: cachedResponse.userInfo,
            storagePolicy: cachedResponse.storagePolicy
        )

        super.storeCachedResponse(newCachedResponse, for: dataTask)
    }
}
