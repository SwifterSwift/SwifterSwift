//
//  CalendarExtension.swift
//  SwifterSwift
//
//  Created by Chaithanya Prathyush on 09/11/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

class CalendarExtensionTests: XCTestCase {
    
    func testNumberOfDaysInMonth() {
        let calendar = Calendar(identifier: .gregorian)
        let longMonths = [1, 3, 5, 7, 8, 10, 12]
        let shortMonths = [4, 6, 9, 11]
        let febDateComponent = DateComponents(year: 2015, month: 2)
        let febDate = calendar.date(from: febDateComponent)!
        let leapYearDateComponent = DateComponents(year: 2020, month: 2)
        let leapYearDate = calendar.date(from: leapYearDateComponent)!
        let longMonthsDateComponents = longMonths.map { DateComponents(year: 2015, month: $0) }
        let shortMonthsDateComponents = shortMonths.map { DateComponents(year: 2015, month: $0) }
        let longMonthDates = longMonthsDateComponents.flatMap { calendar.date(from: $0) }
        let shortMonthDates = shortMonthsDateComponents.flatMap { calendar.date(from: $0) }
        longMonthDates.forEach { XCTAssert(calendar.numberOfDaysInMonth(for: $0) == 31) }
        shortMonthDates.forEach { XCTAssert(calendar.numberOfDaysInMonth(for: $0) == 30) }
        XCTAssert(calendar.numberOfDaysInMonth(for: febDate) == 28)
        XCTAssert(calendar.numberOfDaysInMonth(for: leapYearDate) == 29)
    }
    
    func testNumberOfMonthsInYear() {
        let gregorian = Calendar(identifier: .gregorian)
        let hebrew = Calendar(identifier: .hebrew)
        let ethiopic = Calendar(identifier: .ethiopicAmeteMihret)
        let today = Date()
        
        XCTAssert(gregorian.numberOfMonthsInYear(for: today) == 12)
        XCTAssert(hebrew.numberOfMonthsInYear(for: today) == 13)
        XCTAssert(ethiopic.numberOfMonthsInYear(for: today) == 13)
    }
    
    func testNumberOfDaysInYear() {
        let gregorian = Calendar(identifier: .gregorian)
        let gregorianLeapYearComps = DateComponents(year:2016, month: 2)
        let gregorianLeapYear = gregorian.date(from: gregorianLeapYearComps)!
        let gregorianNonLeapYearComps = DateComponents(year:2015, month: 2)
        let gregorianNonLeapYear = gregorian.date(from: gregorianNonLeapYearComps)!
        
        XCTAssert(gregorian.numberOfDaysInYear(for: gregorianLeapYear) == 366)
        XCTAssert(gregorian.numberOfDaysInYear(for: gregorianNonLeapYear) == 365)
        
        let chinese = Calendar(identifier: .chinese)
        let chineseLeapYearComps = DateComponents(year: 2000, month: 2)
        let chineseLeapYear = chinese.date(from: chineseLeapYearComps)!
        let chineseNonLeapYearComps = DateComponents(year: 1999, month: 2)
        let chineseNonLeapYear = chinese.date(from: chineseNonLeapYearComps)!
        XCTAssert(chinese.numberOfDaysInYear(for: chineseLeapYear) == 384)
        XCTAssert(chinese.numberOfDaysInYear(for: chineseNonLeapYear) == 354)
    }
}
