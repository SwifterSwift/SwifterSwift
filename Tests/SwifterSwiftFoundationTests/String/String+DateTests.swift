// String+DateTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringDateTests {
    static let utc = TimeZone(identifier: "UTC") ?? .gmt

    static func components(of date: Date, in timeZone: TimeZone) -> DateComponents {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
    }

    @Test
    func parsesDateInGivenTimeZone() throws {
        let date = try #require("2026-10-30".date(withFormat: "yyyy-MM-dd", timeZone: Self.utc))
        #expect(date == Date(timeIntervalSince1970: 1_793_318_400))
    }

    @Test
    func parsesDateAndTime() throws {
        let date = try #require("30/10/2026 14:05:09".date(withFormat: "dd/MM/yyyy HH:mm:ss", timeZone: Self.utc))
        let components = Self.components(of: date, in: Self.utc)
        #expect(components.year == 2026)
        #expect(components.month == 10)
        #expect(components.day == 30)
        #expect(components.hour == 14)
        #expect(components.minute == 5)
        #expect(components.second == 9)
    }

    @Test
    func parsesFractionalSeconds() throws {
        let date = try #require("2012-08-12 17:00:00.5".date(withFormat: "yyyy-dd-MM HH:mm:ss.S", timeZone: Self.utc))
        #expect(date.timeIntervalSince1970 == 1_354_986_000.5)
    }

    @Test
    func usesTheGivenTimeZone() throws {
        let tokyo = try #require(TimeZone(identifier: "Asia/Tokyo"))
        let newYork = try #require(TimeZone(identifier: "America/New_York"))
        let inTokyo = try #require("2026-01-15 09:00".date(withFormat: "yyyy-MM-dd HH:mm", timeZone: tokyo))
        let inNewYork = try #require("2026-01-15 09:00".date(withFormat: "yyyy-MM-dd HH:mm", timeZone: newYork))
        #expect(inNewYork.timeIntervalSince(inTokyo) == 14 * 3600)
    }

    @Test
    func prefersTimeZoneInTheString() throws {
        let tokyo = try #require(TimeZone(identifier: "Asia/Tokyo"))
        let date = try #require("2026-10-30T12:00:00Z".date(withFormat: "yyyy-MM-dd'T'HH:mm:ssXXX", timeZone: tokyo))
        #expect(Self.components(of: date, in: Self.utc).hour == 12)
    }

    @Test
    func handlesDaylightSavingTransitions() throws {
        let newYork = try #require(TimeZone(identifier: "America/New_York"))
        let before = try #require("2026-03-08 01:30".date(withFormat: "yyyy-MM-dd HH:mm", timeZone: newYork))
        let after = try #require("2026-03-08 03:30".date(withFormat: "yyyy-MM-dd HH:mm", timeZone: newYork))
        // 02:00 to 03:00 doesn't exist on that day, so the two wall-clock times are only one hour apart.
        #expect(after.timeIntervalSince(before) == 3600)
    }

    @Test
    func parsesEnglishMonthNamesByDefault() throws {
        let date = try #require("30 October 2026".date(withFormat: "dd MMMM yyyy", timeZone: Self.utc))
        #expect(Self.components(of: date, in: Self.utc).month == 10)
    }

    @Test
    func parsesMonthNamesInTheGivenLocale() throws {
        let french = Locale(identifier: "fr_FR")
        let date = try #require("30 octobre 2026".date(withFormat: "dd MMMM yyyy", locale: french, timeZone: Self.utc))
        #expect(Self.components(of: date, in: Self.utc).month == 10)
        #expect("30 octobre 2026".date(withFormat: "dd MMMM yyyy", timeZone: Self.utc) == nil)
    }

    @Test
    func usesTheGregorianCalendarByDefaultEvenForOtherLocales() throws {
        let thai = Locale(identifier: "th_TH")
        let date = try #require("2026-10-30".date(withFormat: "yyyy-MM-dd", locale: thai, timeZone: Self.utc))
        #expect(Self.components(of: date, in: Self.utc).year == 2026)
    }

    @Test
    func usesTheGivenCalendar() throws {
        let buddhist = Calendar(identifier: .buddhist)
        let date = try #require("2569-10-30".date(withFormat: "yyyy-MM-dd", timeZone: Self.utc, calendar: buddhist))
        #expect(Self.components(of: date, in: Self.utc).year == 2026)
    }

    @Test(arguments: ["2026-10-30", "2026-02-30", " 2026-1-5 "])
    func parsesLikeDateFormatter(_ string: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = Self.utc
        formatter.dateFormat = "yyyy-MM-dd"
        #expect(string.date(withFormat: "yyyy-MM-dd", timeZone: Self.utc) == formatter.date(from: string))
    }

    #if canImport(Darwin)
    @Test
    func followsTheLeniencyOfDateFormatterOnApplePlatforms() throws {
        let rolledOver = try #require("2026-02-30".date(withFormat: "yyyy-MM-dd", timeZone: Self.utc))
        let components = Self.components(of: rolledOver, in: Self.utc)
        #expect(components.month == 3)
        #expect(components.day == 2)
        #expect(" 2026-1-5 ".date(withFormat: "yyyy-MM-dd", timeZone: Self.utc) != nil)
    }
    #endif

    @Test(arguments: [
        ("2026-13-45", "yyyy-MM-dd"),
        ("2026-02-32", "yyyy-MM-dd"),
        ("2026-01-05x", "yyyy-MM-dd"),
        ("not a date", "yyyy-MM-dd"),
        ("", "yyyy-MM-dd"),
        ("2012-12-08 17:00:00.0", "Hello world!"),
        ("2026-10-30", "")
    ])
    func returnsNilWhenStringDoesNotMatch(_ string: String, _ format: String) {
        #expect(string.date(withFormat: format, timeZone: Self.utc) == nil)
    }
}
#endif
