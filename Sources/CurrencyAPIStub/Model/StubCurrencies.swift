import Foundation
import CurrencyAPIData

public enum StubCurrencies {
    public static let all = [
        EUR,
        USD,
        GBP,
        CHF,
        NOK,
        PLN,
        CZK,
        RON,
        HUF,
        JPY,
        EGP,
        BTC,
        ETH,
        XPT,
        XAG,
        XAU,
    ]

    public static let EUR = Currency(
        symbol: "€",
        name: "Euro",
        symbolNative: "€",
        decimalDigits: 2,
        rounding: 0,
        code: "EUR",
        namePlural: "Euros",
        type: .fiat,
        countries: [
            "AD",
            "AT",
            "AX",
            "BE",
            "BL",
            "CP",
            "CY",
            "DE",
            "EA",
            "EE",
            "ES",
            "EU",
            "FI",
            "FR",
            "FX",
            "GF",
            "GP",
            "GR",
            "IC",
            "IE",
            "IT",
            "LT",
            "LU",
            "LV",
            "MC",
            "ME",
            "MF",
            "MQ",
            "MT",
            "NL",
            "PM",
            "PT",
            "RE",
            "SI",
            "SK",
            "SM",
            "TF",
            "VA",
            "XK",
            "YT",
            "ZW",
        ]
    )

    public static let USD = Currency(
        symbol: "$",
        name: "US Dollar",
        symbolNative: "$",
        decimalDigits: 2,
        rounding: 0,
        code: "USD",
        namePlural: "US dollars",
        type: .fiat,
        countries: [
            "AC",
            "AS",
            "BQ",
            "DG",
            "EC",
            "FM",
            "GU",
            "HT",
            "IO",
            "MH",
            "MP",
            "PA",
            "PR",
            "PW",
            "SV",
            "TC",
            "TL",
            "UM",
            "US",
            "VG",
            "VI",
            "ZW"
        ]
    )

    public static let GBP = Currency(
        symbol: "£",
        name: "British Pound Sterling",
        symbolNative: "£",
        decimalDigits: 2,
        rounding: 0,
        code: "GBP",
        namePlural: "British pounds sterling",
        type: .fiat,
        countries: [
            "GB",
            "GG",
            "GS",
            "IM",
            "JE",
            "TA",
            "UK",
            "ZW"
        ]
    )

    public static let CHF = Currency(
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

    public static let NOK = Currency(
        symbol: "Nkr",
        name: "Norwegian Krone",
        symbolNative: "kr",
        decimalDigits: 2,
        rounding: 0,
        code: "NOK",
        namePlural: "Norwegian kroner",
        type: .fiat,
        countries: [
            "BV",
            "NO",
            "SJ"
        ]
    )

    public static let PLN = Currency(
        symbol: "zł",
        name: "Polish Zloty",
        symbolNative: "zł",
        decimalDigits: 2,
        rounding: 0,
        code: "PLN",
        namePlural: "Polish zlotys",
        type: .fiat,
        countries: [
            "PL"
        ]
    )

    public static let CZK = Currency(
        symbol: "Kč",
        name: "Czech Republic Koruna",
        symbolNative: "Kč",
        decimalDigits: 2,
        rounding: 0,
        code: "CZK",
        namePlural: "Czech Republic korunas",
        type: .fiat,
        countries: [
            "CZ"
        ]
    )

    public static let RON = Currency(
        symbol: "RON",
        name: "Romanian Leu",
        symbolNative: "RON",
        decimalDigits: 2,
        rounding: 0,
        code: "RON",
        namePlural: "Romanian lei",
        type: .fiat,
        countries: [
            "RO"
        ]
    )

    public static let HUF = Currency(
        symbol: "Ft",
        name: "Hungarian Forint",
        symbolNative: "Ft",
        decimalDigits: 0,
        rounding: 0,
        code: "HUF",
        namePlural: "Hungarian forints",
        type: .fiat,
        countries: [
            "HU"
        ]
    )

    public static let JPY = Currency(
        symbol: "¥",
        name: "Japanese Yen",
        symbolNative: "￥",
        decimalDigits: 0,
        rounding: 0,
        code: "JPY",
        namePlural: "Japanese yen",
        type: .fiat,
        countries: [
            "JP"
        ]
    )


    public static let EGP = Currency(
        symbol: "EGP",
        name: "Egyptian Pound",
        symbolNative: "ج.م.‏",
        decimalDigits: 2,
        rounding: 0,
        code: "EGP",
        namePlural: "Egyptian pounds",
        type: .fiat,
        countries: [
            "EG",
            "PS"
        ]
    )

    public static let BTC = Currency(
        symbol: "₿",
        name: "Bitcoin",
        symbolNative: "₿",
        decimalDigits: 8,
        rounding: 0,
        code: "BTC",
        namePlural: "Bitcoins",
        type: .crypto,
        countries: []
    )

    public static let ETH = Currency(
        symbol: "Ξ",
        name: "Ethereum",
        symbolNative: "Ξ",
        decimalDigits: 18,
        rounding: 0,
        code: "ETH",
        namePlural: "Ethereum",
        type: .crypto,
        countries: []
    )

    public static let XPT = Currency(
        symbol: "XPT",
        name: "Platinum Ounce",
        symbolNative: "XPT",
        decimalDigits: 6,
        rounding: 0,
        code: "XPT",
        namePlural: "Platinum Ounces",
        type: .metal,
        countries: []
    )

    public static let XAG = Currency(
        symbol: "XAG",
        name: "Silver Ounce",
        symbolNative: "XAG",
        decimalDigits: 2,
        rounding: 0,
        code: "XAG",
        namePlural: "Silver Ounces",
        type: .metal,
        countries: []
    )

    public static let XAU = Currency(
        symbol: "XAU",
        name: "Gold Ounce",
        symbolNative: "XAU",
        decimalDigits: 2,
        rounding: 0,
        code: "XAU",
        namePlural: "Gold Ounces",
        type: .metal,
        countries: []
    )
}
