// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "currency-api",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CurrencyAPI",
            targets: ["CurrencyAPI"]
        ),
        .library(
            name: "CurrencyAPIData",
            targets: ["CurrencyAPIData"]
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
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-overture", from: "0.5.0"),
    ],
    targets: [
        .target(
            name: "CurrencyAPI",
            dependencies: [
                "CurrencyAPIData",
            ]
        ),
        .target(
            name: "CurrencyAPIData",
            dependencies: [
            ]
        ),
        .target(
            name: "CurrencyAPILive",
            dependencies: [
                "CurrencyAPI",
                "CurrencyAPIData",
                .product(name: "Overture", package: "swift-overture"),
            ]
        ),
        .target(
            name: "CurrencyAPIStub",
            dependencies: [
                "CurrencyAPI",
                "CurrencyAPIData",
                .product(name: "Overture", package: "swift-overture"),
            ]
        )
    ]
)
