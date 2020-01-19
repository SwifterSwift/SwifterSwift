//
//  LocaleExtensionsTests.swift
//  SwifterSwift
//
//  Created by Basem Emara on 4/19/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class LocaleExtensionsTests: XCTestCase {

    func testPosix() {
        let test: Locale = .posix
        XCTAssertEqual(test.identifier, "en_US_POSIX")
    }

    func testIs12HourTimeFormat() {
        let twelveHourLocale = Locale(identifier: "en")
        XCTAssertTrue(twelveHourLocale.is12HourTimeFormat)

        let twentyFourLocale = Locale(identifier: "ru")
        XCTAssertFalse(twentyFourLocale.is12HourTimeFormat)
    }

}

#endif
