// Calendar+NumberOfDaysInYearTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct CalendarNumberOfDaysInYearTests {
    private static func calendar(_ identifier: Calendar.Identifier, _ timeZone: String = "UTC") throws -> Calendar {
        var calendar = Calendar(identifier: identifier)
        calendar.timeZone = try #require(TimeZone(identifier: timeZone))
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    @Test(arguments: [(2020, 366), (2021, 365), (2024, 366), (2025, 365), (2000, 366), (1900, 365), (2100, 365)])
    func countsTheDaysOfGregorianYears(_ year: Int, _ days: Int) throws {
        let calendar = try Self.calendar(.gregorian)
        let first = try #require(calendar.date(from: DateComponents(year: year, month: 1, day: 1)))
        let last = try #require(calendar.date(from: DateComponents(year: year, month: 12, day: 31, hour: 23)))
        #expect(calendar.numberOfDaysInYear(for: first) == days)
        #expect(calendar.numberOfDaysInYear(for: last) == days)
    }

    @Test
    func matchesTheDocumentationExample() throws {
        let calendar = try Self.calendar(.gregorian)
        let date = try #require(calendar.date(from: DateComponents(year: 2024, month: 6, day: 1)))
        #expect(calendar.numberOfDaysInYear(for: date) == 366)

        let islamic = try Self.calendar(.islamicUmmAlQura)
        #expect(islamic.component(.year, from: date) == 1445)
        #expect(islamic.numberOfDaysInYear(for: date) == 354)
    }

    @Test(arguments: [
        (Calendar.Identifier.hebrew, 5784, 383), (.hebrew, 5785, 355), (.hebrew, 5786, 354), (.hebrew, 5787, 385),
        (.islamicCivil, 1445, 355), (.islamicCivil, 1446, 354), (.persian, 1403, 366), (.persian, 1404, 365),
        (.coptic, 1743, 366), (.coptic, 1744, 365)
    ])
    func countsTheDaysOfNonGregorianYears(_ identifier: Calendar.Identifier, _ year: Int, _ days: Int) throws {
        let calendar = try Self.calendar(identifier)
        let date = try #require(calendar.date(from: DateComponents(year: year, month: 1, day: 1, hour: 12)))
        #expect(calendar.numberOfDaysInYear(for: date) == days)

        // The count matches the calendar's own year length.
        let interval = try #require(calendar.dateInterval(of: .year, for: date))
        #expect(calendar.dateComponents([.day], from: interval.start, to: interval.end).day == days)
    }

    @Test
    func countsChineseYearsWithALeapMonth() throws {
        let calendar = try Self.calendar(.chinese, "Asia/Shanghai")
        let leapYear = try #require(calendar.date(from: DateComponents(year: 42, month: 1, day: 1, hour: 12)))
        let commonYear = try #require(calendar.date(from: DateComponents(year: 43, month: 1, day: 1, hour: 12)))
        #expect(calendar.numberOfDaysInYear(for: leapYear) == 384)
        #expect(calendar.numberOfDaysInYear(for: commonYear) == 354)
    }

    @Test
    func usesTheYearInTheCalendarsTimeZone() throws {
        let newYork = try Self.calendar(.gregorian, "America/New_York")
        let date = try #require(newYork.date(from: DateComponents(year: 2023, month: 12, day: 31, hour: 22)))
        #expect(newYork.numberOfDaysInYear(for: date) == 365)
        #expect(try Self.calendar(.gregorian).numberOfDaysInYear(for: date) == 366)
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsNilForNonFiniteDates(_ interval: Double) throws {
        let calendar = try Self.calendar(.gregorian)
        #expect(calendar.numberOfDaysInYear(for: Date(timeIntervalSinceReferenceDate: interval)) == nil)
    }
}
#endif
