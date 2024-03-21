// LocaleExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

final class LocaleExtensionsTests: XCTestCase {
    func testPosix() {
        let test: Locale = .posix
        XCTAssertEqual(test.identifier, "en_US_POSIX")
    }

    func testIs12HourTimeFormat() {
        let twelveHourLocale = Locale(identifier: "en")
        XCTAssert(twelveHourLocale.is12HourTimeFormat)

        let twentyFourLocale = Locale(identifier: "ru")
        XCTAssertFalse(twentyFourLocale.is12HourTimeFormat)
    }

    func testFlagEmoji() {
        XCTAssertEqual(Locale.flagEmoji(forRegionCode: "AC"), "🇦🇨")
        XCTAssertEqual(Locale.flagEmoji(forRegionCode: "ZW"), "🇿🇼")
        #if !os(Linux)
        XCTAssertNil(Locale.flagEmoji(forRegionCode: ""))
        XCTAssertNil(Locale.flagEmoji(forRegionCode: "ac"))
        #endif

        for regionCode in Locale.isoRegionCodes {
            XCTAssertNotNil(Locale.flagEmoji(forRegionCode: regionCode))
        }
    }
}

#endif
