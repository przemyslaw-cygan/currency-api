# Currency API Client

[Currency API](https://currencyapi.com/) Client for iOS

## Installation

You can add Currency API to an Xcode project by adding it to your project as a package.

> https://github.com/przemyslaw-cygan/currency-api

If you want to use Dependencies in a [SwiftPM](https://swift.org/package-manager/) project, it's as
simple as adding it to your `Package.swift`:

``` swift
dependencies: [
  .package(url: "https://github.com/przemyslaw-cygan/currency-api", from: "0.1.0")
]
```

And then adding the product to any target that needs access to the library:

```swift
.product(name: "CurrencyAPICore", package: "currency-api"),
.product(name: "CurrencyAPILive", package: "currency-api"),
.product(name: "CurrencyAPIStub", package: "currency-api"),
```

### Package products:
* `CurrencyAPI` - client core
* `CurrencyAPILive` - live implementation
* `CurrencyAPIStub` - stub implementation

## How To Use

### Live Client

```swift
import CurrencyAPICore
import CurrencyAPILive

let client = CurrencyAPI.Client.live(
    apiKey: "<API_KEY>",
    session: .shared
)
```

### Stub Client

```swift
import CurrencyAPICore
import CurrencyAPIStub

let client = CurrencyAPI.Client.stub()
```

You can provide `date` (default: 2024-01-01) used:
* in `ResponseMeta` for `HistoricalResponse`, `LatestResponse`, `ConvertResponse`.
* for adjusting `ExchangeRate` value (see: `ExchangeRate.Stub.dateAdjustedValue`)

```swift
import CurrencyAPICore
import CurrencyAPIStub

let client = CurrencyAPI.Client.stub(lastUpdatedAt: .now)
```

### Custom

You can always provide your own custom implementation according to your needs

```swift
import CurrencyAPICore
import CurrencyAPIData

let client = CurrencyAPI.Client(
    convert: { request in fatalError() },
    currencies: { request in
        CurrenciesResponse(
            data: [
                "CHF": Currency(
                    symbol: "CHF",
                    name: "Swiss Franc",
                    symbolNative: "CHF",
                    decimalDigits: 2,
                    rounding: 0,
                    code: "CHF",
                    namePlural: "Swiss francs",
                    type: .fiat,
                    countries: [
                        "CH",
                        "LI"
                    ]
                )
            ]
        )
    },
    convert: { request in fatalError() },
    historicalRange: { request in fatalError() },
    historical:  { request in fatalError() },
    latest: { request in fatalError() },
    status: { request in fatalError() }
)
```

## Examples

You can find more information about request parameters in [Currency API Documentation](https://currencyapi.com/docs)

```swift
let client: CurrencyAPI.Client

let convertResponse = try await client.convert(ConvertRequest(
    value: "123.45",
    date: .now,
    baseCurrency: "CHF",
    currencies: ["USD", "EUR"],
    type: .fiat
))

let currenciesResponse = try await client.currencies(CurrenciesRequest(
    currencies: ["USD", "EUR"],
    type: .fiat
))

let latestResponse = try await client.latest(LatestRequest(
    baseCurrency: "CHF",
    currencies: ["USD", "EUR"],
    type: .fiat
))

let historicalRangeResponse = try await client.historicalRange(HistoricalRangeRequest(
    dateRange: DateRange(
        start: .distantPast,
        end: .now,
        accuracy: .day
    ),
    baseCurrency: "CHF",
    currencies: ["USD", "EUR"],
    type: .fiat
))

let historicalResponse = try await client.historical(HistoricalRequest(
    date: .now,
    baseCurrency: "CHF",
    currencies: ["USD", "EUR"],
    type: .fiat
))

let statusResponse = try await client.status(StatusRequest())
```
