// Locale+PosixTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct LocalePosixTests {
    @Test
    func isTheEnglishUSPosixLocale() {
        #expect(Locale.posix.identifier == "en_US_POSIX")
        #expect(Locale.posix == Locale(identifier: "en_US_POSIX"))
        #expect(Locale.posix.language.languageCode == .english)
        #expect(Locale.posix.region == .unitedStates)
        #expect(Locale.posix.variant == .posix)
    }

    @Test
    func differsFromTheEnglishUSLocale() {
        #expect(Locale.posix != Locale(identifier: "en_US"))
    }

    @Test
    func usesFixedSeparatorsDigitsAndCalendar() {
        #expect(Locale.posix.decimalSeparator == ".")
        #expect(Locale.posix.numberingSystem.identifier == "latn")
        #expect(Locale.posix.calendar.identifier == .gregorian)
    }

    @Test
    func formatsFixedFormatDates() throws {
        let formatter = DateFormatter()
        formatter.locale = .posix
        formatter.timeZone = TimeZone(identifier: "UTC") ?? .gmt
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        #expect(formatter.string(from: Date(timeIntervalSince1970: 1_793_370_309)) == "Fri, 30 Oct 2026 14:25:09")
        let date = try #require(formatter.date(from: "Fri, 30 Oct 2026 14:25:09"))
        #expect(date == Date(timeIntervalSince1970: 1_793_370_309))
    }

    @Test
    func formatsNumbersWithAPeriodAsTheDecimalSeparator() {
        let formatter = NumberFormatter()
        formatter.locale = .posix
        formatter.numberStyle = .decimal
        #expect(formatter.decimalSeparator == ".")
        #expect(formatter.string(from: -567.25) == "-567.25")
    }
}
#endif
