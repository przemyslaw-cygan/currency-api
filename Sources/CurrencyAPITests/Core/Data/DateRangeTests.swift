import Foundation
import Testing
import struct CurrencyAPICore.DateRange

@Suite struct DateRangeTests {
    let shortDateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter
    }()

    let longDateFormatter = ISO8601DateFormatter()

    @Test func accuracyInterval() {
        #expect(DateRange.Accuracy.day.interval == 24 * 60 * 60)
        #expect(DateRange.Accuracy.hour.interval == 60 * 60)
        #expect(DateRange.Accuracy.quarterHour.interval == 15 * 60)
        #expect(DateRange.Accuracy.minute.interval == 60)
    }

    @Test func successfullInitialization() throws {
        let start = self.shortDateFormatter.date(from: "2020-01-01")!
        let end = self.shortDateFormatter.date(from: "2020-01-10")!
        #expect(DateRange(start: start, end: end, accuracy: .day) != nil)
    }

    @Test func failingInitialization() throws {
        let start = self.shortDateFormatter.date(from: "2020-01-11")!
        let end = self.shortDateFormatter.date(from: "2020-01-10")!
        #expect(DateRange(start: start, end: end, accuracy: .day) == nil)
    }

    @Test func datesWithDayAccuracy() throws {
        let start = self.shortDateFormatter.date(from: "2020-01-01")!
        let end = self.shortDateFormatter.date(from: "2020-01-10")!
        let dateRange = try #require(DateRange(start: start, end: end, accuracy: .day))

        let expectedDates = [
            "2020-01-01",
            "2020-01-02",
            "2020-01-03",
            "2020-01-04",
            "2020-01-05",
            "2020-01-06",
            "2020-01-07",
            "2020-01-08",
            "2020-01-09",
            "2020-01-10",
        ].map(self.shortDateFormatter.date(from:))

        #expect(dateRange.dates == expectedDates)
    }

    @Test func datesWithHourAccuracy() throws {
        let start = self.longDateFormatter.date(from: "2020-01-01T12:13:14Z")!
        let end = self.longDateFormatter.date(from: "2020-01-02T02:10:01Z")!
        let dateRange = try #require(DateRange(start: start, end: end, accuracy: .hour))

        let expectedDates = [
            "2020-01-01T12:13:14Z",
            "2020-01-01T13:13:14Z",
            "2020-01-01T14:13:14Z",
            "2020-01-01T15:13:14Z",
            "2020-01-01T16:13:14Z",
            "2020-01-01T17:13:14Z",
            "2020-01-01T18:13:14Z",
            "2020-01-01T19:13:14Z",
            "2020-01-01T20:13:14Z",
            "2020-01-01T21:13:14Z",
            "2020-01-01T22:13:14Z",
            "2020-01-01T23:13:14Z",
            "2020-01-02T00:13:14Z",
            "2020-01-02T01:13:14Z",
        ].map(self.longDateFormatter.date(from:))

        #expect(dateRange.dates == expectedDates)
    }

    @Test func datesWithQuarterHourAccuracy() throws {
        let start = self.longDateFormatter.date(from: "2020-01-01T23:59:59Z")!
        let end = self.longDateFormatter.date(from: "2020-01-02T01:10:01Z")!
        let dateRange = try #require(DateRange(start: start, end: end, accuracy: .quarterHour))

        let expectedDates = [
            "2020-01-01T23:59:59Z",
            "2020-01-02T00:14:59Z",
            "2020-01-02T00:29:59Z",
            "2020-01-02T00:44:59Z",
            "2020-01-02T00:59:59Z",
        ].map(self.longDateFormatter.date(from:))

        #expect(dateRange.dates == expectedDates)
    }

    @Test func datesWithMinuteAccuracy() throws {
        let start = self.longDateFormatter.date(from: "2020-01-01T12:13:14Z")!
        let end = self.longDateFormatter.date(from: "2020-01-01T12:18:16Z")!
        let dateRange = try #require(DateRange(start: start, end: end, accuracy: .minute))

        let expectedDates = [
            "2020-01-01T12:13:14Z",
            "2020-01-01T12:14:14Z",
            "2020-01-01T12:15:14Z",
            "2020-01-01T12:16:14Z",
            "2020-01-01T12:17:14Z",
            "2020-01-01T12:18:14Z",
        ].map(self.longDateFormatter.date(from:))

        #expect(dateRange.dates == expectedDates)
    }
}
