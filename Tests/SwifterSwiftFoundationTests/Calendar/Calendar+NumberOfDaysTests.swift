// Calendar+NumberOfDaysTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct CalendarNumberOfDaysTests {
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
    func countsDateChangesNotElapsedTime() throws {
        let calendar = try Self.calendar(.gregorian, "Europe/London")
        let lateMonday = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12, hour: 23))
        let earlyTuesday = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 13, hour: 1))
        let lateTuesday = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 13, hour: 23))
        #expect(calendar.numberOfDays(from: lateMonday, to: earlyTuesday) == 1)
        #expect(calendar.numberOfDays(from: earlyTuesday, to: lateTuesday) == 0)
        #expect(calendar.numberOfDays(from: lateMonday, to: lateMonday) == 0)
    }

    @Test
    func isNegativeForEarlierDays() throws {
        let calendar = try Self.calendar(.gregorian, "Europe/London")
        let start = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 12, hour: 1))
        let end = try Self.date(calendar, DateComponents(year: 2026, month: 1, day: 2, hour: 23))
        #expect(calendar.numberOfDays(from: start, to: end) == -10)
        #expect(calendar.numberOfDays(from: end, to: start) == 10)
    }

    @Test
    func countsDaysAcrossDaylightSavingTime() throws {
        // The legacy `daysSince` divided by 86,400 and gave 1.958 days here.
        let calendar = try Self.calendar(.gregorian, "America/New_York")
        let saturday = try Self.date(calendar, DateComponents(year: 2026, month: 3, day: 7, hour: 23))
        let monday = try Self.date(calendar, DateComponents(year: 2026, month: 3, day: 9, hour: 23))
        #expect(monday.timeIntervalSince(saturday) == 47 * 3_600)
        #expect(calendar.numberOfDays(from: saturday, to: monday) == 2)

        let october = try Self.date(calendar, DateComponents(year: 2026, month: 10, day: 31, hour: 0, minute: 30))
        let november = try Self.date(calendar, DateComponents(year: 2026, month: 11, day: 1, hour: 23, minute: 59))
        #expect(november.timeIntervalSince(october) > 2 * 86_400 - 3_600)
        #expect(calendar.numberOfDays(from: october, to: november) == 1)
    }

    @Test
    func countsDaysWhenClocksChangeAtMidnight() throws {
        // In Santiago, clocks jump from 00:00 to 01:00 on September 6, 2026, so that day starts at 01:00.
        let calendar = try Self.calendar(.gregorian, "America/Santiago")
        let changeDay = try Self.date(calendar, DateComponents(year: 2026, month: 9, day: 6, hour: 12))
        let nextDay = try Self.date(calendar, DateComponents(year: 2026, month: 9, day: 7, hour: 0, minute: 30))
        let startOfChangeDay = calendar.startOfDay(for: changeDay)
        #expect(calendar.component(.hour, from: startOfChangeDay) == 1)

        // Comparing the starts of the two days gives 0, because they're only 23 hours apart.
        let naive = calendar.dateComponents([.day], from: startOfChangeDay, to: calendar.startOfDay(for: nextDay))
        #expect(naive.day == 0)
        #expect(calendar.numberOfDays(from: changeDay, to: nextDay) == 1)
        #expect(calendar.numberOfDays(from: nextDay, to: changeDay) == -1)
    }

    @Test
    func crossesYearBoundariesAndLeapDays() throws {
        let calendar = try Self.calendar(.gregorian, "Pacific/Auckland")
        let newYearsEve = try Self.date(calendar, DateComponents(year: 2026, month: 12, day: 31, hour: 23, minute: 59))
        let newYear = try Self.date(calendar, DateComponents(year: 2027, month: 1, day: 1))
        #expect(calendar.numberOfDays(from: newYearsEve, to: newYear) == 1)

        let february = try Self.date(calendar, DateComponents(year: 2024, month: 2, day: 28, hour: 12))
        let march = try Self.date(calendar, DateComponents(year: 2024, month: 3, day: 1, hour: 12))
        #expect(calendar.numberOfDays(from: february, to: march) == 2)

        let startOf2024 = try Self.date(calendar, DateComponents(year: 2024, month: 1, day: 1))
        let startOf2025 = try Self.date(calendar, DateComponents(year: 2025, month: 1, day: 1))
        #expect(calendar.numberOfDays(from: startOf2024, to: startOf2025) == 366)
    }

    @Test
    func usesTheDaysOfTheCalendarsTimeZone() throws {
        let tokyo = try Self.calendar(.gregorian, "Asia/Tokyo")
        let london = try Self.calendar(.gregorian, "Europe/London")
        let start = try Self.date(london, DateComponents(year: 2026, month: 6, day: 1, hour: 12))  // 20:00 in Tokyo
        let end = start.addingTimeInterval(6 * 3_600)  // 18:00 in London, 02:00 the next day in Tokyo
        #expect(london.numberOfDays(from: start, to: end) == 0)
        #expect(tokyo.numberOfDays(from: start, to: end) == 1)
    }

    @Test
    func countsDaysInOtherCalendars() throws {
        let hebrew = try Self.calendar(.hebrew, "Asia/Jerusalem")
        let startOf5787 = try Self.date(hebrew, DateComponents(year: 5787, month: 1, day: 1))
        let startOf5788 = try Self.date(hebrew, DateComponents(year: 5788, month: 1, day: 1))
        #expect(hebrew.numberOfDays(from: startOf5787, to: startOf5788) == 385)

        let chinese = try Self.calendar(.chinese, "Asia/Shanghai")
        var leapComponents = DateComponents(year: 42, month: 6, day: 1)
        leapComponents.isLeapMonth = true
        let leapMonth = try Self.date(chinese, leapComponents)
        let regularMonth = try Self.date(chinese, DateComponents(year: 42, month: 6, day: 1))
        let days = try #require(chinese.numberOfDays(from: regularMonth, to: leapMonth))
        #expect(days == 29 || days == 30)
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsNilForNonFiniteDates(_ interval: Double) throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let nonFinite = Date(timeIntervalSinceReferenceDate: interval)
        #expect(calendar.numberOfDays(from: nonFinite, to: Date(timeIntervalSinceReferenceDate: 0)) == nil)
        #expect(calendar.numberOfDays(from: Date(timeIntervalSinceReferenceDate: 0), to: nonFinite) == nil)
    }
}
#endif
