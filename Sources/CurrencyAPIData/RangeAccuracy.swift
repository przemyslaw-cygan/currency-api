import Foundation

public enum RangeAccuracy: String, Codable, Hashable, Sendable {
    case day
    case hour
    case quarterHour
    case minute
}
