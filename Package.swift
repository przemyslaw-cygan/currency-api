// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "currency-api",
    platforms: [
      .iOS(.v13),
      .macOS(.v12),
      .tvOS(.v13),
      .watchOS(.v6),
    ],
    products: [
        .library(
            name: "CurrencyAPICore",
            targets: ["CurrencyAPICore"]
        ),
        .library(
            name: "CurrencyAPILive",
            targets: ["CurrencyAPILive"]
        ),
        .library(
            name: "CurrencyAPIStub",
            targets: ["CurrencyAPIStub"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CurrencyAPICore",
            dependencies: []
        ),
        .target(
            name: "CurrencyAPILive",
            dependencies: ["CurrencyAPICore"]
        ),
        .target(
            name: "CurrencyAPIStub",
            dependencies: ["CurrencyAPICore"]
        ),
        .testTarget(
            name: "CurrencyAPICoreTests",
            dependencies: ["CurrencyAPICore"]
        ),
        .testTarget(
            name: "CurrencyAPILiveTests",
            dependencies: ["CurrencyAPILive"]
        ),
    ]
)
