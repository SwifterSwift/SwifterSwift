// Date+IsWithinTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateIsWithinTests {
    private static func calendar(_ identifier: Calendar.Identifier, _ timeZone: String) throws -> Calendar {
        var calendar = Calendar(identifier: identifier)
        calendar.timeZone = try #require(TimeZone(identifier: timeZone))
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    private static func date(_ calendar: Calendar, _ components: DateComponents) throws -> Date {
        try #require(calendar.date(from: components))
    }

    @Test
    func includesBothBounds() throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let center = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12, hour: 12))
        #expect(center.isWithin(0, .minute, of: center, in: calendar))
        #expect(center.addingTimeInterval(600).isWithin(10, .minute, of: center, in: calendar))
        #expect(center.addingTimeInterval(-600).isWithin(10, .minute, of: center, in: calendar))
        #expect(!center.addingTimeInterval(601).isWithin(10, .minute, of: center, in: calendar))
        #expect(!center.addingTimeInterval(-600.5).isWithin(10, .minute, of: center, in: calendar))
        #expect(!center.addingTimeInterval(1).isWithin(0, .minute, of: center, in: calendar))
    }

    @Test
    func doesNotTruncateTheDifference() throws {
        // These dates are almost 2 days apart, so they aren't within 1 day.
        let calendar = try Self.calendar(.gregorian, "UTC")
        let start = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 1, hour: 0))
        let end = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 2, hour: 23, minute: 59))
        #expect(!end.isWithin(1, .day, of: start, in: calendar))
        #expect(end.isWithin(2, .day, of: start, in: calendar))
    }

    @Test
    func countsCalendarDaysAcrossDaylightSavingTime() throws {
        let calendar = try Self.calendar(.gregorian, "America/New_York")
        // March 8, 2026 lasts 23 hours in New York.
        let saturday = try Self.date(calendar, DateComponents(year: 2026, month: 3, day: 7, hour: 12))
        let sunday = try Self.date(calendar, DateComponents(year: 2026, month: 3, day: 8, hour: 12))
        #expect(sunday.timeIntervalSince(saturday) == 23 * 3_600)
        #expect(sunday.isWithin(1, .day, of: saturday, in: calendar))
        #expect(saturday.isWithin(1, .day, of: sunday, in: calendar))
        #expect(sunday.isWithin(23, .hour, of: saturday, in: calendar))
        #expect(!sunday.isWithin(22, .hour, of: saturday, in: calendar))

        // November 1, 2026 lasts 25 hours.
        let october = try Self.date(calendar, DateComponents(year: 2026, month: 10, day: 31, hour: 12))
        let november = try Self.date(calendar, DateComponents(year: 2026, month: 11, day: 1, hour: 12))
        #expect(november.timeIntervalSince(october) == 25 * 3_600)
        #expect(november.isWithin(1, .day, of: october, in: calendar))
        #expect(!november.isWithin(24, .hour, of: october, in: calendar))
    }

    @Test
    func clampsMonthsToTheEndOfShorterMonths() throws {
        let calendar = try Self.calendar(.gregorian, "Europe/Paris")
        let endOfMarch = try Self.date(calendar, DateComponents(year: 2026, month: 3, day: 31))
        let endOfFebruary = try Self.date(calendar, DateComponents(year: 2026, month: 2, day: 28))
        #expect(endOfFebruary.isWithin(1, .month, of: endOfMarch, in: calendar))
        #expect(!endOfFebruary.addingTimeInterval(-1).isWithin(1, .month, of: endOfMarch, in: calendar))
    }

    @Test
    func crossesYearBoundaries() throws {
        let calendar = try Self.calendar(.gregorian, "Pacific/Auckland")
        let newYearsEve = try Self.date(calendar, DateComponents(year: 2026, month: 12, day: 31, hour: 23))
        let newYear = try Self.date(calendar, DateComponents(year: 2027, month: 1, day: 1, hour: 1))
        #expect(newYear.isWithin(2, .hour, of: newYearsEve, in: calendar))
        #expect(!newYear.isWithin(1, .hour, of: newYearsEve, in: calendar))
        #expect(newYear.isWithin(1, .year, of: newYearsEve, in: calendar))
    }

    @Test
    func usesTheMonthsOfTheGivenCalendar() throws {
        let calendar = try Self.calendar(.islamicUmmAlQura, "Asia/Riyadh")
        let start = try Self.date(calendar, DateComponents(year: 1447, month: 9, day: 1, hour: 12))
        let nextMonth = try Self.date(calendar, DateComponents(year: 1447, month: 10, day: 1, hour: 12))
        #expect(nextMonth.isWithin(1, .month, of: start, in: calendar))
        #expect(!nextMonth.addingTimeInterval(1).isWithin(1, .month, of: start, in: calendar))
    }

    @Test(arguments: [-1, Int.min])
    func returnsFalseForNegativeValues(_ value: Int) throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let date = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12))
        #expect(!date.isWithin(value, .day, of: date, in: calendar))
    }

    @Test(arguments: [Calendar.Component.calendar, .timeZone, .isLeapMonth])
    func returnsFalseForComponentsTheCalendarCantAdd(_ component: Calendar.Component) throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let date = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12))
        #expect(!date.isWithin(1, component, of: date, in: calendar))
    }

    @Test
    func handlesLargeValuesWithoutCrashing() throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let date = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12))
        // `Calendar.date(byAdding:value:to:)` overflows silently for `Int.max`, so only the absence of a crash is
        // guaranteed there.
        _ = date.addingTimeInterval(86_400).isWithin(Int.max, .day, of: date, in: calendar)
        _ = date.isWithin(Int.max, .year, of: date, in: calendar)
        _ = date.isWithin(Int.max, .nanosecond, of: date, in: calendar)
        #expect(date.addingTimeInterval(86_400).isWithin(1_000_000, .day, of: date, in: calendar))
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsFalseForNonFiniteDates(_ interval: Double) throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let date = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12))
        let nonFinite = Date(timeIntervalSinceReferenceDate: interval)
        #expect(!nonFinite.isWithin(1, .day, of: date, in: calendar))
        #expect(!date.isWithin(1, .day, of: nonFinite, in: calendar))
    }
}
#endif
