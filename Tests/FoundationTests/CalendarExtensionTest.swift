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
    
    override func setUp() {
        super.setUp()
    }
    
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
        let longMonthDates = longMonthsDateComponents.flatMap { calendar.date(from: $0) }
        let shortMonthDates = shortMonthsDateComponents.flatMap { calendar.date(from: $0) }
        longMonthDates.forEach { XCTAssert(calendar.numberOfDaysInMonth(for: $0) == 31) }
        shortMonthDates.forEach { XCTAssert(calendar.numberOfDaysInMonth(for: $0) == 30) }
        XCTAssert(calendar.numberOfDaysInMonth(for: febDate) == 28)
        XCTAssert(calendar.numberOfDaysInMonth(for: leapYearDate) == 29)
    }
}
