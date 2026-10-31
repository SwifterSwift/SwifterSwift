// Date+QuarterTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateQuarterTests {
    private static func calendar(_ identifier: Calendar.Identifier, _ timeZone: String = "UTC") throws -> Calendar {
        var calendar = Calendar(identifier: identifier)
        calendar.timeZone = try #require(TimeZone(identifier: timeZone))
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    @Test(arguments: [(1, 1), (2, 1), (3, 1), (4, 2), (5, 2), (6, 2), (7, 3), (8, 3), (9, 3), (10, 4), (11, 4), (12, 4)]
    )
    func returnsTheQuarterOfAGregorianMonth(_ month: Int, _ quarter: Int) throws {
        let calendar = try Self.calendar(.gregorian)
        let first = try #require(calendar.date(from: DateComponents(year: 2026, month: month, day: 1)))
        let last = try #require(calendar.date(byAdding: DateComponents(month: 1, second: -1), to: first))
        #expect(first.quarter(in: calendar) == quarter)
        #expect(last.quarter(in: calendar) == quarter)
    }

    @Test(arguments: [
        Calendar.Identifier.islamicUmmAlQura, .islamicCivil, .persian, .indian, .japanese, .buddhist, .republicOfChina
    ])
    func returnsTheQuarterInOtherTwelveMonthCalendars(_ identifier: Calendar.Identifier) throws {
        // `Calendar.component(.quarter, from:)` returns 0 for these calendars.
        let calendar = try Self.calendar(identifier)
        let reference = Date(timeIntervalSinceReferenceDate: 800_000_000)  // May 2026
        let era = calendar.component(.era, from: reference)
        let year = calendar.component(.year, from: reference)
        for month in 1...12 {
            let components = DateComponents(era: era, year: year, month: month, day: 10)
            let date = try #require(calendar.date(from: components))
            #expect(calendar.component(.month, from: date) == month)
            #expect(date.quarter(in: calendar) == (month - 1) / 3 + 1)
        }
    }

    @Test(arguments: [(1, 1), (3, 1), (4, 2), (6, 2), (7, 3), (9, 3), (10, 4), (12, 4), (13, 4)])
    func putsTheThirteenthMonthInTheLastQuarter(_ month: Int, _ quarter: Int) throws {
        for identifier in [Calendar.Identifier.coptic, .ethiopicAmeteMihret] {
            let calendar = try Self.calendar(identifier)
            let date = try #require(calendar.date(from: DateComponents(year: 1742, month: month, day: 3)))
            #expect(date.quarter(in: calendar) == quarter)
        }
    }

    @Test
    func handlesHebrewLeapMonths() throws {
        let calendar = try Self.calendar(.hebrew, "Asia/Jerusalem")
        // 5787 is a leap year with Adar I (month 6); 5786 isn't.
        let expected = [1: 1, 3: 1, 4: 2, 6: 2, 7: 3, 9: 3, 10: 4, 13: 4]
        for (month, quarter) in expected {
            let date = try #require(calendar.date(from: DateComponents(year: 5787, month: month, day: 2)))
            #expect(calendar.component(.month, from: date) == month)
            #expect(date.quarter(in: calendar) == quarter)
        }
        let elul = try #require(calendar.date(from: DateComponents(year: 5786, month: 13, day: 2)))
        #expect(elul.quarter(in: calendar) == 4)
    }

    @Test
    func putsChineseLeapMonthsWithTheMonthTheyRepeat() throws {
        let calendar = try Self.calendar(.chinese, "Asia/Shanghai")
        var components = DateComponents(year: 42, month: 6, day: 10)
        components.isLeapMonth = true
        let leapSixth = try #require(calendar.date(from: components))
        #expect(calendar.dateComponents([.isLeapMonth], from: leapSixth).isLeapMonth == true)
        #expect(leapSixth.quarter(in: calendar) == 2)

        let seventh = try #require(calendar.date(from: DateComponents(year: 42, month: 7, day: 10)))
        #expect(seventh.quarter(in: calendar) == 3)
    }

    @Test
    func usesTheTimeZoneOfTheCalendar() throws {
        let newYork = try Self.calendar(.gregorian, "America/New_York")
        let tokyo = try Self.calendar(.gregorian, "Asia/Tokyo")
        let newYearsEve = try #require(
            newYork.date(from: DateComponents(year: 2026, month: 12, day: 31, hour: 20))
        )
        #expect(newYearsEve.quarter(in: newYork) == 4)
        #expect(newYearsEve.quarter(in: tokyo) == 1)
    }

    @Test
    func matchesTheDocumentationExample() throws {
        let calendar = try Self.calendar(.gregorian, "Asia/Tokyo")
        let date = try #require(calendar.date(from: DateComponents(year: 2026, month: 11, day: 15)))
        #expect(date.quarter(in: calendar) == 4)

        let hebrew = try Self.calendar(.hebrew, "Asia/Tokyo")
        #expect(hebrew.component(.month, from: date) == 3)
        #expect(date.quarter(in: hebrew) == 1)
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsNilForNonFiniteDates(_ interval: Double) throws {
        let calendar = try Self.calendar(.gregorian)
        #expect(Date(timeIntervalSinceReferenceDate: interval).quarter(in: calendar) == nil)
    }
}
#endif
