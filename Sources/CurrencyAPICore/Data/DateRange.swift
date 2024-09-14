import Foundation

public struct DateRange: Hashable {
    public let start: Date
    public let end: Date
    public let accuracy: Accuracy

    public init?(start: Date, end: Date, accuracy: Accuracy) {
        guard (end.timeIntervalSince1970 - start.timeIntervalSince1970) >= accuracy.interval else { return nil }
        self.start = start
        self.end = end
        self.accuracy = accuracy
    }

    public enum Accuracy: String, Codable, Hashable {
        case day
        case hour
        case quarterHour
        case minute
    }
}

public extension DateRange {
    var dates: [Date] {
        var dates: [Date] = []
        var start = self.start
        while start <= self.end {
            dates.append(start)
            start.addTimeInterval(self.accuracy.interval)
        }
        return dates
    }
}

public extension DateRange.Accuracy {
    var interval: TimeInterval {
        switch self {
        case .day:
            60 * 60 * 24
        case .hour:
            60 * 60
        case .minute:
            60
        case .quarterHour:
            60 * 15
        }
    }
}
