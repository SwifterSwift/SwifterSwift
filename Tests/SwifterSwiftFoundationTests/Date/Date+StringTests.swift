// Date+StringTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateStringTests {
    static let utc = TimeZone(identifier: "UTC") ?? .gmt
    /// 2026-10-30 14:25:09.123 UTC, a Friday.
    static let date = Date(timeIntervalSince1970: 1_793_370_309.123)

    @Test
    func formatsTheDateInTheGivenTimeZone() {
        #expect(Self.date.string(withFormat: "yyyy-MM-dd", timeZone: Self.utc) == "2026-10-30")
        #expect(Self.date.string(withFormat: "dd/MM/yyyy HH:mm:ss", timeZone: Self.utc) == "30/10/2026 14:25:09")
        #expect(Self.date.string(withFormat: "HH:mm:ss.SSS", timeZone: Self.utc) == "14:25:09.123")
    }

    static let timeZones: [(identifier: String, expected: String)] = {
        var timeZones = [
            ("Asia/Tokyo", "2026-10-30 23:25 +09:00"),
            ("America/New_York", "2026-10-30 10:25 -04:00")
        ]
        #if !os(Windows)
        // DateFormatter crashes on Windows when it formats a date in Asia/Kolkata.
        timeZones.append(("Asia/Kolkata", "2026-10-30 19:55 +05:30"))
        #endif
        return timeZones
    }()

    @Test(arguments: timeZones)
    func usesTheGivenTimeZone(_ identifier: String, _ expected: String) throws {
        let timeZone = try #require(TimeZone(identifier: identifier))
        let string = Self.date.string(withFormat: "yyyy-MM-dd HH:mm XXX", timeZone: timeZone)
        #expect(string == expected)
    }

    @Test
    func writesZForUTCWithTheXXXPattern() {
        let string = Self.date.string(withFormat: "yyyy-MM-dd'T'HH:mm:ssXXX", timeZone: Self.utc)
        #expect(string == "2026-10-30T14:25:09Z")
    }

    @Test
    func ignoresTheTimeZoneOfTheCalendar() throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = try #require(TimeZone(identifier: "Asia/Tokyo"))
        #expect(Self.date.string(withFormat: "HH:mm", timeZone: Self.utc, calendar: calendar) == "14:25")
    }

    @Test
    func handlesDaylightSavingTransitions() throws {
        let newYork = try #require(TimeZone(identifier: "America/New_York"))
        // Clocks in New York jumped from 02:00 EST to 03:00 EDT at 07:00 UTC on March 8, 2026.
        let transition = Date(timeIntervalSince1970: 1_772_953_200)
        let format = "yyyy-MM-dd HH:mm XXX"
        #expect(transition.string(withFormat: format, timeZone: newYork) == "2026-03-08 03:00 -04:00")
        let before = transition.addingTimeInterval(-1)
        #expect(before.string(withFormat: "HH:mm:ss XXX", timeZone: newYork) == "01:59:59 -05:00")
    }

    @Test
    func usesEnglishNamesAndTheTwentyFourHourClockByDefault() {
        #expect(Self.date.string(withFormat: "EEEE d MMMM yyyy", timeZone: Self.utc) == "Friday 30 October 2026")
        #expect(Self.date.string(withFormat: "h:mm a", timeZone: Self.utc) == "2:25 PM")
        #expect(Self.date.string(withFormat: "HH", timeZone: Self.utc) == "14")
    }

    @Test(arguments: [
        ("fr_FR", "vendredi 30 octobre 2026"),
        ("de_DE", "Freitag 30 Oktober 2026"),
        ("es_ES", "viernes 30 octubre 2026")
    ])
    func usesTheNamesOfTheGivenLocale(_ identifier: String, _ expected: String) {
        let locale = Locale(identifier: identifier)
        #expect(Self.date.string(withFormat: "EEEE d MMMM yyyy", locale: locale, timeZone: Self.utc) == expected)
    }

    @Test
    func usesTheDigitsOfTheGivenLocale() {
        let egyptianArabic = Locale(identifier: "ar_EG")
        #expect(Self.date.string(withFormat: "yyyy", locale: egyptianArabic, timeZone: Self.utc) == "٢٠٢٦")
        #expect(Self.date.string(withFormat: "yyyy", timeZone: Self.utc) == "2026")
    }

    @Test
    func usesTheGregorianCalendarByDefaultEvenForOtherLocales() {
        let thai = Locale(identifier: "th_TH")
        let buddhistUS = Locale(identifier: "en_US@calendar=buddhist")
        #expect(Self.date.string(withFormat: "yyyy-MM-dd", locale: thai, timeZone: Self.utc) == "2026-10-30")
        #expect(Self.date.string(withFormat: "yyyy-MM-dd", locale: buddhistUS, timeZone: Self.utc) == "2026-10-30")
    }

    @Test(arguments: [
        (Calendar.Identifier.buddhist, "2569-10-30"),
        (.islamicUmmAlQura, "1448-05-19"),
        (.hebrew, "5787-02-19")
    ])
    func usesTheGivenCalendar(_ identifier: Calendar.Identifier, _ expected: String) {
        let calendar = Calendar(identifier: identifier)
        #expect(Self.date.string(withFormat: "yyyy-MM-dd", timeZone: Self.utc, calendar: calendar) == expected)
    }

    @Test
    func keepsQuotedLiteralText() {
        let format = "'Day' D 'of' yyyy, 'it''s' EEE"
        #expect(Self.date.string(withFormat: format, timeZone: Self.utc) == "Day 303 of 2026, it's Fri")
    }

    @Test
    func returnsAnEmptyStringForAnEmptyFormat() {
        #expect(Self.date.string(withFormat: "", timeZone: Self.utc).isEmpty)
    }

    @Test
    func formatsDatesFarFromNow() {
        #expect(Date.distantFuture.string(withFormat: "yyyy-MM-dd", timeZone: Self.utc) == "4001-01-01")
        #expect(Date.distantPast.string(withFormat: "G yyyy", timeZone: Self.utc) == "AD 0001")
        let beforeEpoch = Date(timeIntervalSince1970: -1)
        #expect(beforeEpoch.string(withFormat: "yyyy-MM-dd HH:mm:ss", timeZone: Self.utc) == "1969-12-31 23:59:59")
    }

    @Test(arguments: [Double.nan, .infinity, -.infinity, .greatestFiniteMagnitude])
    func matchesDateFormatterForInvalidDates(_ interval: TimeInterval) {
        let date = Date(timeIntervalSinceReferenceDate: interval)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = Self.utc
        formatter.dateFormat = "yyyy-MM-dd"
        #expect(date.string(withFormat: "yyyy-MM-dd", timeZone: Self.utc) == formatter.string(from: date))
    }

    @Test
    func roundTripsThroughDateFormatter() throws {
        let format = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        let tokyo = try #require(TimeZone(identifier: "Asia/Tokyo"))
        let text = Self.date.string(withFormat: format, timeZone: tokyo)
        #expect(text == "2026-10-30T23:25:09.123+09:00")
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        let parsed = try #require(formatter.date(from: text))
        #expect(abs(parsed.timeIntervalSince(Self.date)) < 0.001)
    }
}
#endif
