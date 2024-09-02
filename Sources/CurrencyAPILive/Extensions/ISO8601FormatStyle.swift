import Foundation

public extension Date.ISO8601FormatStyle {
    static let short = Date.ISO8601FormatStyle()
        .year()
        .month()
        .day()
        .dateSeparator(.dash)
}
