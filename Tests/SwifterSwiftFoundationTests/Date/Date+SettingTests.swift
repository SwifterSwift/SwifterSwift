// Date+SettingTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateSettingTests {
    private static let fields: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second]

    private static func calendar(_ identifier: Calendar.Identifier, _ timeZone: String) throws -> Calendar {
        var calendar = Calendar(identifier: identifier)
        calendar.timeZone = try #require(TimeZone(identifier: timeZone))
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    private static func newYork() throws -> Calendar {
        try calendar(.gregorian, "America/New_York")
    }

    @Test(arguments: [
        (Calendar.Component.year, 2030),
        (.month, 6),
        (.day, 28),
        (.hour, 17),
        (.minute, 45),
        (.second, 30)
    ])
    func setsOneComponentAndKeepsTheOthers(_ component: Calendar.Component, _ value: Int) throws {
        let calendar = try Self.newYork()
        let components = DateComponents(year: 2026, month: 1, day: 15, hour: 9, minute: 10, second: 20)
        let date = try #require(calendar.date(from: components)).addingTimeInterval(0.25)
        let result = try #require(date.setting(component, to: value, in: calendar))

        var expected = calendar.dateComponents(Self.fields, from: date)
        expected.setValue(value, for: component)
        #expect(calendar.dateComponents(Self.fields, from: result) == expected)
        #expect(result.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 1) == 0.25)
    }

    @Test
    func setsNanosecondAndKeepsTheRest() throws {
        let calendar = try Self.newYork()
        let date = try #require(calendar.date(from: DateComponents(year: 2026, month: 1, day: 15, hour: 9)))
        let result = try #require(date.setting(.nanosecond, to: 500_000_000, in: calendar))
        #expect(result.timeIntervalSince(date) == 0.5)

        let back = try #require(result.setting(.nanosecond, to: 0, in: calendar))
        #expect(back == date)
    }

    @Test(arguments: [-1, 1_000_000_000, Int.max, Int.min])
    func returnsNilForNanosecondOutOfRange(_ value: Int) throws {
        let calendar = try Self.newYork()
        let date = try #require(calendar.date(from: DateComponents(year: 2026, month: 1, day: 15)))
        #expect(date.setting(.nanosecond, to: value, in: calendar) == nil)
    }

    @Test
    func keepsWallClockTimeWhenClocksSpringForward() throws {
        // Clocks in New York jump from 02:00 EST to 03:00 EDT on March 8, 2026.
        let calendar = try Self.newYork()
        let date = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 0, minute: 30))
        )
        let result = try #require(date.setting(.hour, to: 3, in: calendar))
        #expect(calendar.component(.hour, from: result) == 3)
        #expect(calendar.component(.minute, from: result) == 30)
        // 00:30 EST to 03:30 EDT is 2 elapsed hours, not 3.
        #expect(result.timeIntervalSince(date) == 2 * 3_600)

        let afterChange = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 10))
        )
        let early = try #require(afterChange.setting(.hour, to: 1, in: calendar))
        #expect(calendar.component(.hour, from: early) == 1)
        #expect(calendar.timeZone.secondsFromGMT(for: early) == -5 * 3_600)
    }

    @Test
    func returnsNilForSkippedWallClockTime() throws {
        let calendar = try Self.newYork()
        let date = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 0, minute: 30))
        )
        #expect(date.setting(.hour, to: 2, in: calendar) == nil)

        let dayBefore = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 3, day: 7, hour: 2, minute: 30))
        )
        #expect(dayBefore.setting(.day, to: 8, in: calendar) == nil)
    }

    @Test
    func keepsWallClockTimeWhenClocksFallBack() throws {
        // Clocks in New York go back from 02:00 EDT to 01:00 EST on November 1, 2026.
        let calendar = try Self.newYork()
        let date = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 11, day: 1, hour: 0, minute: 30))
        )
        let result = try #require(date.setting(.hour, to: 3, in: calendar))
        #expect(calendar.component(.hour, from: result) == 3)
        // 00:30 EDT to 03:30 EST is 4 elapsed hours, not 3.
        #expect(result.timeIntervalSince(date) == 4 * 3_600)

        // In the repeated hour, a date in EDT picks the first 01:30.
        let first = try #require(date.setting(.hour, to: 1, in: calendar))
        #expect(calendar.component(.hour, from: first) == 1)
        #expect(calendar.timeZone.secondsFromGMT(for: first) == -4 * 3_600)
    }

    @Test
    func keepsTheOriginalOffsetInARepeatedHour() throws {
        let calendar = try Self.newYork()
        let firstOneOClock = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 11, day: 1, hour: 1, minute: 10))
        )
        let secondOneOClock = firstOneOClock.addingTimeInterval(3_600)
        #expect(calendar.component(.hour, from: secondOneOClock) == 1)
        #expect(calendar.timeZone.secondsFromGMT(for: secondOneOClock) == -5 * 3_600)

        let result = try #require(secondOneOClock.setting(.minute, to: 50, in: calendar))
        #expect(result.timeIntervalSince(secondOneOClock) == 40 * 60)

        let later = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 11, day: 1, hour: 3, minute: 30))
        )
        let back = try #require(later.setting(.hour, to: 1, in: calendar))
        #expect(calendar.timeZone.secondsFromGMT(for: back) == -5 * 3_600)
        #expect(later.timeIntervalSince(back) == 2 * 3_600)
    }

    @Test
    func returnsNilInsteadOfClampingTheDay() throws {
        let calendar = try Self.newYork()
        let endOfJanuary = try #require(calendar.date(from: DateComponents(year: 2026, month: 1, day: 31, hour: 9)))
        #expect(endOfJanuary.setting(.month, to: 2, in: calendar) == nil)
        #expect(endOfJanuary.setting(.month, to: 4, in: calendar) == nil)

        let march = try #require(endOfJanuary.setting(.month, to: 3, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day, .hour], from: march)
                == DateComponents(
                    year: 2026, month: 3, day: 31, hour: 9))

        let leapDay = try #require(calendar.date(from: DateComponents(year: 2024, month: 2, day: 29)))
        #expect(leapDay.setting(.year, to: 2025, in: calendar) == nil)
        let nextLeapDay = try #require(leapDay.setting(.year, to: 2028, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day], from: nextLeapDay)
                == DateComponents(
                    year: 2028, month: 2, day: 29))

        let february = try #require(calendar.date(from: DateComponents(year: 2026, month: 2, day: 28)))
        #expect(february.setting(.day, to: 29, in: calendar) == nil)
    }

    @Test(arguments: [
        (Calendar.Component.month, 0), (.month, 13), (.day, 0), (.day, 32), (.day, -1), (.hour, -1), (.hour, 24),
        (.minute, 60), (.second, 60), (.year, 0), (.year, -5), (.era, 2), (.year, Int.max), (.year, Int.min),
        (.hour, Int.max), (.day, Int.min)
    ])
    func returnsNilForValuesOutOfRange(_ component: Calendar.Component, _ value: Int) throws {
        let calendar = try Self.newYork()
        let date = try #require(calendar.date(from: DateComponents(year: 2026, month: 1, day: 15, hour: 9)))
        #expect(date.setting(component, to: value, in: calendar) == nil)
    }

    @Test(arguments: [
        Calendar.Component.weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear,
        .calendar, .timeZone, .isLeapMonth
    ])
    func returnsNilForComponentsThatCantBeSet(_ component: Calendar.Component) throws {
        let calendar = try Self.newYork()
        let date = try #require(calendar.date(from: DateComponents(year: 2026, month: 1, day: 15)))
        #expect(date.setting(component, to: 1, in: calendar) == nil)
    }

    @Test
    func handlesYearBoundaries() throws {
        let calendar = try Self.calendar(.gregorian, "Asia/Tokyo")
        let date = try #require(
            calendar.date(from: DateComponents(year: 2026, month: 12, day: 31, hour: 23, minute: 59, second: 59))
        )
        let firstDay = try #require(date.setting(.day, to: 1, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day, .hour], from: firstDay)
                == DateComponents(
                    year: 2026, month: 12, day: 1, hour: 23))

        let january = try #require(date.setting(.month, to: 1, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day], from: january)
                == DateComponents(
                    year: 2026, month: 1, day: 31))

        let nextYear = try #require(date.setting(.year, to: 2027, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day, .second], from: nextYear)
                == DateComponents(
                    year: 2027, month: 12, day: 31, second: 59))
    }

    @Test
    func usesTheTimeZoneOfTheCalendar() throws {
        let tokyo = try Self.calendar(.gregorian, "Asia/Tokyo")
        let newYork = try Self.newYork()
        let date = try #require(tokyo.date(from: DateComponents(year: 2026, month: 6, day: 15, hour: 12)))

        let inTokyo = try #require(date.setting(.hour, to: 8, in: tokyo))
        let inNewYork = try #require(date.setting(.hour, to: 8, in: newYork))
        #expect(tokyo.component(.hour, from: inTokyo) == 8)
        #expect(newYork.component(.hour, from: inNewYork) == 8)
        #expect(tokyo.component(.day, from: inTokyo) == 15)
        #expect(newYork.component(.day, from: inNewYork) == 14)
    }

    @Test
    func setsTheEra() throws {
        let calendar = try Self.calendar(.gregorian, "UTC")
        let date = try #require(calendar.date(from: DateComponents(year: 44, month: 3, day: 15)))
        let beforeChrist = try #require(date.setting(.era, to: 0, in: calendar))
        #expect(
            calendar.dateComponents([.era, .year, .month, .day], from: beforeChrist)
                == DateComponents(
                    era: 0, year: 44, month: 3, day: 15))
    }

    @Test
    func respectsHebrewLeapMonths() throws {
        let calendar = try Self.calendar(.hebrew, "Asia/Jerusalem")
        // 5786 has 12 months, so month 6 (Adar I) doesn't exist; 5787 has 13.
        let commonYear = try #require(calendar.date(from: DateComponents(year: 5786, month: 1, day: 10, hour: 12)))
        #expect(commonYear.setting(.month, to: 6, in: calendar) == nil)
        let adar = try #require(commonYear.setting(.month, to: 7, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day], from: adar)
                == DateComponents(
                    year: 5786, month: 7, day: 10))

        let leapYear = try #require(commonYear.setting(.year, to: 5787, in: calendar))
        let adarI = try #require(leapYear.setting(.month, to: 6, in: calendar))
        #expect(
            calendar.dateComponents([.year, .month, .day], from: adarI)
                == DateComponents(
                    year: 5787, month: 6, day: 10))
    }

    @Test
    func returnsNilForADayMissingFromAnIslamicMonth() throws {
        let calendar = try Self.calendar(.islamicUmmAlQura, "Asia/Riyadh")
        let date = try #require(calendar.date(from: DateComponents(year: 1447, month: 1, day: 1, hour: 12)))
        let lastDay = try #require(calendar.range(of: .day, in: .month, for: date)).upperBound - 1
        let last = try #require(date.setting(.day, to: lastDay, in: calendar))
        #expect(calendar.component(.day, from: last) == lastDay)
        #expect(date.setting(.day, to: lastDay + 1, in: calendar) == nil)
    }

    @Test
    func keepsAndLeavesChineseLeapMonths() throws {
        let calendar = try Self.calendar(.chinese, "Asia/Shanghai")
        // 2025 (year 42 of the current cycle) has a leap sixth month.
        var components = DateComponents(year: 42, month: 6, day: 5, hour: 12)
        components.isLeapMonth = true
        let date = try #require(calendar.date(from: components))
        #expect(calendar.dateComponents([.isLeapMonth], from: date).isLeapMonth == true)

        let sameMonth = try #require(date.setting(.day, to: 20, in: calendar))
        let sameMonthComponents = calendar.dateComponents([.month, .day, .isLeapMonth], from: sameMonth)
        #expect(sameMonthComponents.month == 6)
        #expect(sameMonthComponents.day == 20)
        #expect(sameMonthComponents.isLeapMonth == true)

        let regular = try #require(date.setting(.month, to: 6, in: calendar))
        #expect(calendar.dateComponents([.isLeapMonth], from: regular).isLeapMonth == false)
        #expect(regular < date)
    }

    @Test
    func setsTheYearInTheBuddhistCalendar() throws {
        let buddhist = try Self.calendar(.buddhist, "Asia/Bangkok")
        let gregorian = try Self.calendar(.gregorian, "Asia/Bangkok")
        let date = try #require(gregorian.date(from: DateComponents(year: 2017, month: 12, day: 25)))
        let result = try #require(date.setting(.year, to: 2569, in: buddhist))
        #expect(
            gregorian.dateComponents([.year, .month, .day], from: result)
                == DateComponents(
                    year: 2026, month: 12, day: 25))
    }

    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func returnsNilForNonFiniteDates(_ interval: Double) throws {
        let calendar = try Self.newYork()
        #expect(Date(timeIntervalSinceReferenceDate: interval).setting(.hour, to: 1, in: calendar) == nil)
    }
}
#endif
