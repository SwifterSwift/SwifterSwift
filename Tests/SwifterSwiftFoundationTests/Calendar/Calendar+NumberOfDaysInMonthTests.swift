// Calendar+NumberOfDaysInMonthTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct CalendarNumberOfDaysInMonthTests {
    private static func calendar(_ identifier: Calendar.Identifier, _ timeZone: String = "UTC") throws -> Calendar {
        var calendar = Calendar(identifier: identifier)
        calendar.timeZone = try #require(TimeZone(identifier: timeZone))
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    @Test(arguments: [
        (2025, 1, 31), (2025, 2, 28), (2025, 3, 31), (2025, 4, 30), (2025, 5, 31), (2025, 6, 30), (2025, 7, 31),
        (2025, 8, 31), (2025, 9, 30), (2025, 10, 31), (2025, 11, 30), (2025, 12, 31), (2024, 2, 29), (2000, 2, 29),
        (1900, 2, 28), (2100, 2, 28)
    ])
    func countsTheDaysOfGregorianMonths(_ year: Int, _ month: Int, _ days: Int) throws {
        let calendar = try Self.calendar(.gregorian)
        let first = try #require(calendar.date(from: DateComponents(year: year, month: month, day: 1)))
        let last = try #require(calendar.date(from: DateComponents(year: year, month: month, day: days, hour: 23)))
        #expect(calendar.numberOfDaysInMonth(for: first) == days)
        #expect(calendar.numberOfDaysInMonth(for: last) == days)
    }

    @Test
    func isNotAffectedByDaylightSavingTime() throws {
        let calendar = try Self.calendar(.gregorian, "America/New_York")
        let march = try #require(calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 12)))
        let november = try #require(calendar.date(from: DateComponents(year: 2026, month: 11, day: 1, hour: 12)))
        #expect(calendar.numberOfDaysInMonth(for: march) == 31)
        #expect(calendar.numberOfDaysInMonth(for: november) == 30)
    }

    @Test
    func usesTheMonthInTheCalendarsTimeZone() throws {
        let newYork = try Self.calendar(.gregorian, "America/New_York")
        let date = try #require(newYork.date(from: DateComponents(year: 2026, month: 1, day: 31, hour: 22)))
        #expect(newYork.numberOfDaysInMonth(for: date) == 31)
        #expect(try Self.calendar(.gregorian, "UTC").numberOfDaysInMonth(for: date) == 28)
    }

    @Test
    func countsTheDaysOfLunarMonths() throws {
        let islamic = try Self.calendar(.islamicUmmAlQura, "Asia/Riyadh")
        let hebrew = try Self.calendar(.hebrew, "Asia/Jerusalem")
        for month in 1...12 {
            let date = try #require(islamic.date(from: DateComponents(year: 1447, month: month, day: 1, hour: 12)))
            let days = try #require(islamic.numberOfDaysInMonth(for: date))
            #expect(days == 29 || days == 30)
            let next = try #require(islamic.date(byAdding: .day, value: days, to: date))
            #expect(islamic.component(.day, from: next) == 1)
        }
        // Tishri always has 30 days and Tevet 29.
        let tishri = try #require(hebrew.date(from: DateComponents(year: 5787, month: 1, day: 15)))
        let tevet = try #require(hebrew.date(from: DateComponents(year: 5787, month: 4, day: 15)))
        #expect(hebrew.numberOfDaysInMonth(for: tishri) == 30)
        #expect(hebrew.numberOfDaysInMonth(for: tevet) == 29)
    }

    @Test
    func countsTheShortThirteenthMonthOfTheCopticCalendar() throws {
        let calendar = try Self.calendar(.coptic)
        let common = try #require(calendar.date(from: DateComponents(year: 1741, month: 13, day: 1)))
        let leap = try #require(calendar.date(from: DateComponents(year: 1743, month: 13, day: 1)))
        let regular = try #require(calendar.date(from: DateComponents(year: 1741, month: 12, day: 1)))
        #expect(calendar.numberOfDaysInMonth(for: common) == 5)
        #expect(calendar.numberOfDaysInMonth(for: leap) == 6)
        #expect(calendar.numberOfDaysInMonth(for: regular) == 30)
    }

    @Test
    func handlesTheDistantPastAndFuture() throws {
        let calendar = try Self.calendar(.gregorian)
        #expect(calendar.numberOfDaysInMonth(for: .distantPast) == 31)
        #expect(calendar.numberOfDaysInMonth(for: .distantFuture) == 31)
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsNilForNonFiniteDates(_ interval: Double) throws {
        let calendar = try Self.calendar(.gregorian)
        #expect(calendar.numberOfDaysInMonth(for: Date(timeIntervalSinceReferenceDate: interval)) == nil)
    }
}
#endif
