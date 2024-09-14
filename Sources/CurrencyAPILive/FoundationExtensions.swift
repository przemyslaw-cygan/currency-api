import Foundation

extension JSONDecoder {
    static let live: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension JSONEncoder {
    static let live: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}

extension Date {
    var shortFormat: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate
        ]
        return formatter.string(from: self)
    }

    var longFormat: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
}

extension Array where Element == URLQueryItem {
    mutating func append(name: String, value: String?) {
        guard let value, !value.isEmpty else { return }
        self.append(URLQueryItem(name: name, value: value))
    }
}
