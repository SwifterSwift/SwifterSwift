// Date+RoundedTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateRoundedTests {
    private static func calendar(_ timeZone: String) throws -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = try #require(TimeZone(identifier: timeZone))
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    private static func date(
        _ calendar: Calendar,
        _ year: Int,
        _ month: Int,
        _ day: Int,
        _ hour: Int,
        _ minute: Int,
        _ second: Int = 0
    ) throws -> Date {
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        return try #require(calendar.date(from: components))
    }

    // (minutes, seconds after 12:00:00, expected seconds after 12:00:00)
    @Test(arguments: [
        (5, 0.0, 0.0), (5, 149.0, 0.0), (5, 149.999, 0.0), (5, 150.0, 300.0), (5, 179.0, 300.0), (5, 299.0, 300.0),
        (10, 299.0, 0.0), (10, 300.0, 600.0), (15, 449.0, 0.0), (15, 450.0, 900.0), (30, 899.0, 0.0),
        (30, 900.0, 1_800.0), (60, 1_799.0, 0.0), (60, 1_800.0, 3_600.0), (1, 29.0, 0.0), (1, 30.0, 60.0),
        (120, 3_599.0, 0.0), (120, 3_600.0, 7_200.0)
    ])
    func roundsToTheNearestMultiple(_ minutes: Int, _ offset: Double, _ expected: Double) throws {
        let calendar = try Self.calendar("UTC")
        let noon = try Self.date(calendar, 2026, 1, 12, 12, 0)
        let result = noon.addingTimeInterval(offset).rounded(toNearestMinutes: minutes, in: calendar.timeZone)
        #expect(result == noon.addingTimeInterval(expected))
    }

    @Test
    func countsSecondsTowardTheRounding() throws {
        // The legacy `nearestFiveMinutes` ignored seconds and rounded 12:02:59 down to 12:00.
        let calendar = try Self.calendar("UTC")
        let date = try Self.date(calendar, 2026, 1, 12, 12, 2, 59)
        let result = try #require(date.rounded(toNearestMinutes: 5, in: calendar.timeZone))
        #expect(result == (try Self.date(calendar, 2026, 1, 12, 12, 5)))
    }

    @Test(arguments: [0, -5, 7, 25, 1_441, 2_880, Int.max, Int.min])
    func returnsNilForStepsThatDontDivideADay(_ minutes: Int) throws {
        let calendar = try Self.calendar("UTC")
        let date = try Self.date(calendar, 2026, 1, 12, 12, 2)
        #expect(date.rounded(toNearestMinutes: minutes, in: calendar.timeZone) == nil)
    }

    @Test
    func roundsUpToMidnightOfTheNextYear() throws {
        let calendar = try Self.calendar("Europe/Paris")
        let date = try Self.date(calendar, 2026, 12, 31, 23, 50)
        let result = try #require(date.rounded(toNearestMinutes: 30, in: calendar.timeZone))
        #expect(result == (try Self.date(calendar, 2027, 1, 1, 0, 0)))

        let day = try #require(date.rounded(toNearestMinutes: 1_440, in: calendar.timeZone))
        #expect(day == result)
    }

    @Test
    func roundsTheWallClockInTimeZonesWithHalfHourOffsets() throws {
        let kolkata = try Self.calendar("Asia/Kolkata")
        let date = try Self.date(kolkata, 2026, 1, 12, 10, 40)
        let result = try #require(date.rounded(toNearestMinutes: 60, in: kolkata.timeZone))
        #expect(result == (try Self.date(kolkata, 2026, 1, 12, 11, 0)))

        let kathmandu = try Self.calendar("Asia/Kathmandu")
        let nepal = try Self.date(kathmandu, 2026, 1, 12, 10, 20)
        let nepalResult = try #require(nepal.rounded(toNearestMinutes: 30, in: kathmandu.timeZone))
        #expect(nepalResult == (try Self.date(kathmandu, 2026, 1, 12, 10, 30)))
    }

    @Test
    func givesDifferentInstantsInDifferentTimeZones() throws {
        let utc = try Self.calendar("UTC")
        let kolkata = try Self.calendar("Asia/Kolkata")
        let date = try Self.date(utc, 2026, 1, 12, 5, 0)  // 10:30 in Kolkata
        #expect(date.rounded(toNearestMinutes: 60, in: utc.timeZone) == date)
        #expect(date.rounded(toNearestMinutes: 60, in: kolkata.timeZone) == date.addingTimeInterval(30 * 60))
    }

    @Test
    func roundsToTheMomentClocksSpringForward() throws {
        // Clocks in New York jump from 02:00 EST to 03:00 EDT on March 8, 2026, so 02:00 doesn't exist.
        let calendar = try Self.calendar("America/New_York")
        let date = try Self.date(calendar, 2026, 3, 8, 1, 55)
        let result = try #require(date.rounded(toNearestMinutes: 15, in: calendar.timeZone))
        #expect(result == date.addingTimeInterval(5 * 60))
        #expect(calendar.dateComponents([.hour, .minute], from: result) == DateComponents(hour: 3, minute: 0))

        let afterChange = try Self.date(calendar, 2026, 3, 8, 3, 5)
        let back = try #require(afterChange.rounded(toNearestMinutes: 15, in: calendar.timeZone))
        #expect(back == afterChange.addingTimeInterval(-5 * 60))
    }

    @Test
    func keepsTheOccurrenceWhenClocksFallBack() throws {
        // Clocks in New York go back from 02:00 EDT to 01:00 EST on November 1, 2026, so 01:00 to 01:59 occur twice.
        let calendar = try Self.calendar("America/New_York")
        let firstOccurrence = try Self.date(calendar, 2026, 11, 1, 1, 10)
        let secondOccurrence = firstOccurrence.addingTimeInterval(3_600)

        #expect(
            firstOccurrence.rounded(toNearestMinutes: 60, in: calendar.timeZone)
                == firstOccurrence.addingTimeInterval(-10 * 60))
        #expect(
            secondOccurrence.rounded(toNearestMinutes: 60, in: calendar.timeZone)
                == secondOccurrence.addingTimeInterval(-10 * 60))

        let lateFirst = try Self.date(calendar, 2026, 11, 1, 1, 50)
        let rounded = try #require(lateFirst.rounded(toNearestMinutes: 60, in: calendar.timeZone))
        #expect(calendar.dateComponents([.hour, .minute], from: rounded) == DateComponents(hour: 2, minute: 0))

        let beforeChange = try Self.date(calendar, 2026, 11, 1, 0, 50)
        let one = try #require(beforeChange.rounded(toNearestMinutes: 60, in: calendar.timeZone))
        #expect(one == beforeChange.addingTimeInterval(10 * 60))
    }

    @Test
    func roundsDatesBeforeTheReferenceDate() throws {
        let calendar = try Self.calendar("UTC")
        let date = try Self.date(calendar, 1969, 7, 20, 20, 17, 40)
        let result = try #require(date.rounded(toNearestMinutes: 5, in: calendar.timeZone))
        #expect(result == (try Self.date(calendar, 1969, 7, 20, 20, 20)))
        let down = try #require(date.addingTimeInterval(-60).rounded(toNearestMinutes: 5, in: calendar.timeZone))
        #expect(down == (try Self.date(calendar, 1969, 7, 20, 20, 15)))
    }

    @Test
    func leavesDatesOnAMultipleUnchanged() throws {
        let calendar = try Self.calendar("Australia/Lord_Howe")
        let date = try Self.date(calendar, 2026, 1, 12, 17, 45)
        #expect(date.rounded(toNearestMinutes: 15, in: calendar.timeZone) == date)
        #expect(date.rounded(toNearestMinutes: 1, in: calendar.timeZone) == date)
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsNilForNonFiniteDates(_ interval: Double) throws {
        let date = Date(timeIntervalSinceReferenceDate: interval)
        #expect(date.rounded(toNearestMinutes: 5, in: try #require(TimeZone(identifier: "UTC"))) == nil)
    }
}
#endif
