// CalendarExtensionTest.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

class CalendarExtensionTests: XCTestCase {
    func testNumberOfDaysInAMonth() {
        let calendar = Calendar(identifier: .gregorian)
        let longMonths = [1, 3, 5, 7, 8, 10, 12]
        let shortMonths = [4, 6, 9, 11]
        let febDateComponent = DateComponents(year: 2015, month: 2)
        let febDate = calendar.date(from: febDateComponent)!
        let leapYearDateComponent = DateComponents(year: 2020, month: 2)
        let leapYearDate = calendar.date(from: leapYearDateComponent)!
        let longMonthsDateComponents = longMonths.map { DateComponents(year: 2015, month: $0) }
        let shortMonthsDateComponents = shortMonths.map { DateComponents(year: 2015, month: $0) }
        let longMonthDates = longMonthsDateComponents.compactMap { calendar.date(from: $0) }
        let shortMonthDates = shortMonthsDateComponents.compactMap { calendar.date(from: $0) }
        longMonthDates.forEach { XCTAssertEqual(calendar.numberOfDaysInMonth(for: $0), 31) }
        shortMonthDates.forEach { XCTAssertEqual(calendar.numberOfDaysInMonth(for: $0), 30) }
        XCTAssertEqual(calendar.numberOfDaysInMonth(for: febDate), 28)
        XCTAssertEqual(calendar.numberOfDaysInMonth(for: leapYearDate), 29)
    }

    func testNumberOfDaysInYear() throws {
        let calendar = Calendar(identifier: .gregorian)

        // 2020 is a leap year
        let leapYear = try XCTUnwrap(calendar.date(from: DateComponents(year: 2020, month: 1, day: 1)))
        XCTAssertEqual(calendar.numberOfDaysInYear(for: leapYear), 366)

        // 2021 is not a leap year
        let normalYear = try XCTUnwrap(calendar.date(from: DateComponents(year: 2021, month: 1, day: 1)))
        XCTAssertEqual(calendar.numberOfDaysInYear(for: normalYear), 365)
    }
}

#endif
