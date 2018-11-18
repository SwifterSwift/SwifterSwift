//
//  DateExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

// swiftlint:disable next type_body_length
final class DateExtensionsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        NSTimeZone.default = TimeZone(abbreviation: "UTC")!
    }

    // swiftlint:disable next cyclomatic_complexity
    func testCalendar() {
        switch Calendar.current.identifier {
        case .buddhist:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .buddhist).identifier)
        case .chinese:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .chinese).identifier)
        case .coptic:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .coptic).identifier)
        case .ethiopicAmeteAlem:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .ethiopicAmeteAlem).identifier)
        case .ethiopicAmeteMihret:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .ethiopicAmeteMihret).identifier)
        case .gregorian:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .gregorian).identifier)
        case .hebrew:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .hebrew).identifier)
        case .indian:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .indian).identifier)
        case .islamic:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .islamic).identifier)
        case .islamicCivil:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .islamicCivil).identifier)
        case .islamicTabular:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .islamicTabular).identifier)
        case .islamicUmmAlQura:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .islamicUmmAlQura).identifier)
        case .iso8601:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .iso8601).identifier)
        case .japanese:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .japanese).identifier)
        case .persian:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .persian).identifier)
        case .republicOfChina:
            XCTAssertEqual(Date().calendar.identifier, Calendar(identifier: .republicOfChina).identifier)
        }
    }

    func testEra() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.era, 1)
    }

    func testQuarter() {
        let date1 = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date1.quarter, 1)

        let date2 = Calendar.current.date(byAdding: .month, value: 4, to: date1)
        XCTAssertEqual(date2?.quarter, 2)

        let date3 = Calendar.current.date(byAdding: .month, value: 8, to: date1)
        XCTAssertEqual(date3?.quarter, 3)

        let date4 = Calendar.current.date(byAdding: .month, value: 11, to: date1)
        XCTAssertEqual(date4?.quarter, 4)
    }

    func testWeekOfYear() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.weekOfYear, 1)

        let dateAfter7Days = Calendar.current.date(byAdding: .day, value: 7, to: date)
        XCTAssertEqual(dateAfter7Days?.weekOfYear, 2)

        let originalDate = Calendar.current.date(byAdding: .day, value: -7, to: dateAfter7Days!)
        XCTAssertEqual(originalDate?.weekOfYear, 1)
    }

    func testWeekOfMonth() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.weekOfMonth, 1)

        let dateAfter7Days = Calendar.current.date(byAdding: .day, value: 7, to: date)
        XCTAssertEqual(dateAfter7Days?.weekOfMonth, 2)

        let originalDate = Calendar.current.date(byAdding: .day, value: -7, to: dateAfter7Days!)
        XCTAssertEqual(originalDate?.weekOfMonth, 1)
    }

    func testYear() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.year, 1970)

        var isLowerComponentsValid: Bool {
            guard date.month == 1 else { return false }
            guard date.day == 2 else { return false }
            guard date.hour == 3 else { return false }
            guard date.minute == 46 else { return false }
            guard date.second == 40 else { return false }
            guard date.nanosecond == 123450040 else { return false }
            return true
        }

        date.year = 2000
        XCTAssertEqual(date.year, 2000)
        XCTAssert(isLowerComponentsValid)

        date.year = 2017
        XCTAssertEqual(date.year, 2017)
        XCTAssert(isLowerComponentsValid)

        date.year = 1988
        XCTAssertEqual(date.year, 1988)
        XCTAssert(isLowerComponentsValid)

        date.year = -100
        XCTAssertEqual(date.year, 1988)
        XCTAssert(isLowerComponentsValid)

        date.year = 0
        XCTAssertEqual(date.year, 1988)
        XCTAssert(isLowerComponentsValid)
    }

    func testMonth() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.month, 1)

        var isLowerComponentsValid: Bool {
            guard date.day == 2 else { return false }
            guard date.hour == 3 else { return false }
            guard date.minute == 46 else { return false }
            guard date.second == 40 else { return false }
            guard date.nanosecond == 123450040 else { return false }
            return true
        }

        date.month = 2
        XCTAssert(isLowerComponentsValid)

        date.month = 14
        XCTAssertEqual(date.month, 2)
        XCTAssert(isLowerComponentsValid)

        date.month = 1
        XCTAssertEqual(date.month, 1)
        XCTAssert(isLowerComponentsValid)

        date.month = 0
        XCTAssertEqual(date.month, 1)
        XCTAssert(isLowerComponentsValid)

        date.month = -3
        XCTAssertEqual(date.month, 1)
        XCTAssert(isLowerComponentsValid)
    }

    func testDay() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.day, 2)

        var isLowerComponentsValid: Bool {
            guard date.hour == 3 else { return false }
            guard date.minute == 46 else { return false }
            guard date.second == 40 else { return false }
            guard date.nanosecond == 123450040 else { return false }
            return true
        }

        date.day = 4
        XCTAssertEqual(date.day, 4)
        XCTAssert(isLowerComponentsValid)

        date.day = 1
        XCTAssertEqual(date.day, 1)
        XCTAssert(isLowerComponentsValid)

        date.day = 0
        XCTAssertEqual(date.day, 1)
        XCTAssert(isLowerComponentsValid)

        date.day = -3
        XCTAssertEqual(date.day, 1)
        XCTAssert(isLowerComponentsValid)

        date.day = 45
        XCTAssertEqual(date.day, 1)
        XCTAssert(isLowerComponentsValid)
    }

    func testWeekday() {
        let date = Date(timeIntervalSince1970: 100000)
        XCTAssertEqual(date.weekday, 6)
    }

    func testHour() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.hour, 3)

        var isLowerComponentsValid: Bool {
            guard date.minute == 46 else { return false }
            guard date.second == 40 else { return false }
            guard date.nanosecond == 123450040 else { return false }
            return true
        }

        date.hour = -3
        XCTAssertEqual(date.hour, 3)
        XCTAssert(isLowerComponentsValid)

        date.hour = 25
        XCTAssertEqual(date.hour, 3)
        XCTAssert(isLowerComponentsValid)

        date.hour = 4
        XCTAssertEqual(date.hour, 4)
        XCTAssert(isLowerComponentsValid)

        date.hour = 1
        XCTAssertEqual(date.hour, 1)
        XCTAssert(isLowerComponentsValid)
    }

    func testMinute() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.minute, 46)

        var isLowerComponentsValid: Bool {
            guard date.second == 40 else { return false }
            guard date.nanosecond == 123450040 else { return false }
            return true
        }

        date.minute = -3
        XCTAssertEqual(date.minute, 46)
        XCTAssert(isLowerComponentsValid)

        date.minute = 71
        XCTAssertEqual(date.minute, 46)
        XCTAssert(isLowerComponentsValid)

        date.minute = 4
        XCTAssertEqual(date.minute, 4)
        XCTAssert(isLowerComponentsValid)

        date.minute = 1
        XCTAssertEqual(date.minute, 1)
        XCTAssert(isLowerComponentsValid)
    }

    func testSecond() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.second, 40)

        var isLowerComponentsValid: Bool {
            guard date.nanosecond == 123450040 else { return false }
            return true
        }

        date.second = -3
        XCTAssertEqual(date.second, 40)
        XCTAssert(isLowerComponentsValid)

        date.second = 71
        XCTAssertEqual(date.second, 40)
        XCTAssert(isLowerComponentsValid)

        date.second = 12
        XCTAssertEqual(date.second, 12)
        XCTAssert(isLowerComponentsValid)

        date.second = 1
        XCTAssertEqual(date.second, 1)
        XCTAssert(isLowerComponentsValid)
    }

    func testNanosecond() {
        var date = Date(timeIntervalSince1970: 100000.123450040)
        XCTAssertEqual(date.nanosecond, 123450040)

        date.nanosecond = -3
        XCTAssertEqual(date.nanosecond, 123450040)

        date.nanosecond = 10000
        XCTAssert(date.nanosecond >= 1000)
        XCTAssert(date.nanosecond <= 100000)
    }

    func testMillisecond() {
        var date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.millisecond, 0)

        date.millisecond = -3
        XCTAssertEqual(date.millisecond, 0)

        date.millisecond = 10
        XCTAssert(date.millisecond >= 9)
        XCTAssert(date.millisecond <= 11)

        date.millisecond = 3
        XCTAssert(date.millisecond >= 2)
        XCTAssert(date.millisecond <= 4)
    }

    func testIsInFuture() {
        let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        let futureDate = Date(timeIntervalSinceNow: 512)

        XCTAssert(futureDate.isInFuture)
        XCTAssertFalse(oldDate.isInFuture)
    }

    func testIsInPast() {
        let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        let futureDate = Date(timeIntervalSinceNow: 512)

        XCTAssert(oldDate.isInPast)
        XCTAssertFalse(futureDate.isInPast)
    }

    func testIsInToday() {
        XCTAssert(Date().isInToday)
        let tomorrow = Date().adding(.day, value: 1)
        XCTAssertFalse(tomorrow.isInToday)
        let yesterday = Date().adding(.day, value: -1)
        XCTAssertFalse(yesterday.isInToday)
    }

    func testIsInYesterday() {
        XCTAssertFalse(Date().isInYesterday)
        let tomorrow = Date().adding(.day, value: 1)
        XCTAssertFalse(tomorrow.isInYesterday)
        let yesterday = Date().adding(.day, value: -1)
        XCTAssert(yesterday.isInYesterday)
    }

    func testIsInTomorrow() {
        XCTAssertFalse(Date().isInTomorrow)
        let tomorrow = Date().adding(.day, value: 1)
        XCTAssert(tomorrow.isInTomorrow)
        let yesterday = Date().adding(.day, value: -1)
        XCTAssertFalse(yesterday.isInTomorrow)
    }

    func testIsInWeekend() {
        let date = Date()
        XCTAssertEqual(date.isInWeekend, Calendar.current.isDateInWeekend(date))
    }

    func testIsWorkday() {
        let date = Date()
        XCTAssertEqual(date.isWorkday, !Calendar.current.isDateInWeekend(date))
    }

    func testIsInCurrentWeek() {
        let date = Date()
        XCTAssert(date.isInCurrentWeek)
        let dateOneYearFromNow = date.adding(.year, value: 1)
        XCTAssertFalse(dateOneYearFromNow.isInCurrentWeek)
    }

    func testIsInCurrentMonth() {
        let date = Date()
        XCTAssert(date.isInCurrentMonth)
        let dateOneYearFromNow = date.adding(.year, value: 1)
        XCTAssertFalse(dateOneYearFromNow.isInCurrentMonth)
    }

    func testIsInCurrentYear() {
        let date = Date()
        XCTAssert(date.isInCurrentYear)
        let dateOneYearFromNow = date.adding(.year, value: 1)
        XCTAssertFalse(dateOneYearFromNow.isInCurrentYear)
    }

    func testIso8601String() {
        let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        XCTAssertEqual(date.iso8601String, "1970-01-01T00:08:32.000Z")
    }

    func testNearestFiveMinutes() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.nearestFiveMinutes, date)

        let date2 = date.adding(.minute, value: 4) // adding 4 minutes
        XCTAssertNotEqual(date2.nearestFiveMinutes, date2)
        XCTAssertEqual(date2.nearestFiveMinutes, date2.adding(.minute, value: 1))

        let date3 = date.adding(.minute, value: 7) // adding 7 minutes
        XCTAssertEqual(date3.nearestFiveMinutes, date3.adding(.minute, value: -2))

        let date4 = date.adding(.hour, value: 1).adding(.minute, value: 2) // adding 1 hour and 2 minutes
        XCTAssertEqual(date4.nearestFiveMinutes, date.adding(.hour, value: 1))
    }

    func testNearestTenMinutes() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.nearestTenMinutes, date)

        let date2 = date.adding(.minute, value: 4) // adding 4 minutes
        XCTAssertEqual(date2.nearestTenMinutes, date)

        let date3 = date.adding(.minute, value: 7) // adding 7 minutes
        XCTAssertEqual(date3.nearestTenMinutes, date.adding(.minute, value: 10))

        let date4 = date.adding(.hour, value: 1).adding(.minute, value: 2) // adding 1 hour and 2 minutes
        XCTAssertEqual(date4.nearestTenMinutes, date.adding(.hour, value: 1))
    }

    func testNearestQuarterHour() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.nearestQuarterHour, date)

        let date2 = date.adding(.minute, value: 4) // adding 4 minutes
        XCTAssertEqual(date2.nearestQuarterHour, date)

        let date3 = date.adding(.minute, value: 12) // adding 12 minutes
        XCTAssertEqual(date3.nearestQuarterHour, date.adding(.minute, value: 15))

        let date4 = date.adding(.hour, value: 1).adding(.minute, value: 2) // adding 1 hour and 2 minutes
        XCTAssertEqual(date4.nearestQuarterHour, date.adding(.hour, value: 1))
    }

    func testNearestHalfHour() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.nearestHalfHour, date)

        let date2 = date.adding(.minute, value: 4) // adding 4 minutes
        XCTAssertEqual(date2.nearestHalfHour, date)

        let date3 = date.adding(.minute, value: 19) // adding 19 minutes
        XCTAssertEqual(date3.nearestHalfHour, date.adding(.minute, value: 30))

        let date4 = date.adding(.hour, value: 1).adding(.minute, value: 2) // adding 1 hour and 2 minutes
        XCTAssertEqual(date4.nearestHalfHour, date.adding(.hour, value: 1))
    }

    func testNearestHour() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(date.nearestHour, date)

        let date2 = date.adding(.minute, value: 4) // adding 4 minutes
        XCTAssertEqual(date2.nearestHour, date)

        let date3 = date.adding(.minute, value: 34) // adding 34 minutes
        XCTAssertEqual(date3.nearestHour, date.adding(.hour, value: 1))
    }

    func testUnixTimestamp() {
        let date = Date()
        XCTAssertEqual(date.unixTimestamp, date.timeIntervalSince1970)

        let date2 = Date(timeIntervalSince1970: 100)
        XCTAssertEqual(date2.unixTimestamp, 100)
    }

    func testAdding() {
        let date = Date(timeIntervalSince1970: 3610) // Jan 1, 1970, 3:00:10 AM

        XCTAssertEqual(date.adding(.second, value: 0), date)
        let date1 = date.adding(.second, value: 10)
        XCTAssertEqual(date1.second, date.second + 10)
        XCTAssertEqual(date1.adding(.second, value: -10), date)

        XCTAssertEqual(date.adding(.minute, value: 0), date)
        let date2 = date.adding(.minute, value: 10)
        XCTAssertEqual(date2.minute, date.minute + 10)
        XCTAssertEqual(date2.adding(.minute, value: -10), date)

        XCTAssertEqual(date.adding(.hour, value: 0), date)
        let date3 = date.adding(.hour, value: 2)
        XCTAssertEqual(date3.hour, date.hour + 2)
        XCTAssertEqual(date3.adding(.hour, value: -2), date)

        XCTAssertEqual(date.adding(.day, value: 0), date)
        let date4 = date.adding(.day, value: 2)
        XCTAssertEqual(date4.day, date.day + 2)
        XCTAssertEqual(date4.adding(.day, value: -2), date)

        XCTAssertEqual(date.adding(.weekOfYear, value: 0), date)
        let date5 = date.adding(.weekOfYear, value: 1)
        XCTAssertEqual(date5.day, date.day + 7)
        XCTAssertEqual(date5.adding(.weekOfYear, value: -1), date)

        XCTAssertEqual(date.adding(.weekOfMonth, value: 0), date)
        let date6 = date.adding(.weekOfMonth, value: 1)
        XCTAssertEqual(date6.day, date.day + 7)
        XCTAssertEqual(date6.adding(.weekOfMonth, value: -1), date)

        XCTAssertEqual(date.adding(.month, value: 0), date)
        let date7 = date.adding(.month, value: 2)
        XCTAssertEqual(date7.month, date.month + 2)
        XCTAssertEqual(date7.adding(.month, value: -2), date)

        XCTAssertEqual(date.adding(.year, value: 0), date)
        let date8 = date.adding(.year, value: 4)
        XCTAssertEqual(date8.year, date.year + 4)
        XCTAssertEqual(date8.adding(.year, value: -4), date)
    }

    // swiftlint:disable next function_body_length
    func testAdd() {
        var date = Date(timeIntervalSince1970: 0)

        date.second = 10
        date.add(.second, value: -1)
        XCTAssertEqual(date.second, 9)
        date.add(.second, value: 0)
        XCTAssertEqual(date.second, 9)

        date.add(.second, value: 1)
        XCTAssertEqual(date.second, 10)

        date.minute = 10
        date.add(.minute, value: -1)
        XCTAssertEqual(date.minute, 9)
        date.add(.minute, value: 0)
        XCTAssertEqual(date.minute, 9)

        date.add(.minute, value: 1)
        XCTAssertEqual(date.minute, 10)

        date.hour = 10
        date.add(.hour, value: -1)
        XCTAssertEqual(date.hour, 9)
        date.add(.hour, value: 0)
        XCTAssertEqual(date.hour, 9)

        date.add(.hour, value: 1)
        XCTAssertEqual(date.hour, 10)

        date.day = 10
        date.add(.day, value: -1)
        XCTAssertEqual(date.day, 9)
        date.add(.day, value: 0)
        XCTAssertEqual(date.day, 9)

        date.add(.day, value: 1)
        XCTAssertEqual(date.day, 10)

        date.month = 10
        date.add(.month, value: -1)
        XCTAssertEqual(date.month, 9)
        date.add(.month, value: 0)
        XCTAssertEqual(date.month, 9)

        date.add(.month, value: 1)
        XCTAssertEqual(date.month, 10)

        date = Date(timeIntervalSince1970: 1514764800)

        date.add(.year, value: -1)
        XCTAssertEqual(date.year, 2017)
        date.add(.year, value: 0)
        XCTAssertEqual(date.year, 2017)

        date.add(.year, value: 1)
        XCTAssertEqual(date.year, 2018)
    }

    func testChanging() {
        let date = Date(timeIntervalSince1970: 0)

        XCTAssertNil(date.changing(.nanosecond, value: -10))
        XCTAssertNotNil(date.changing(.nanosecond, value: 123450040))
        XCTAssertEqual(date.changing(.nanosecond, value: 123450040)?.nanosecond, 123450040)

        XCTAssertNil(date.changing(.second, value: -10))
        XCTAssertNil(date.changing(.second, value: 70))
        XCTAssertNotNil(date.changing(.second, value: 20))
        XCTAssertEqual(date.changing(.second, value: 20)?.second, 20)

        XCTAssertNil(date.changing(.minute, value: -10))
        XCTAssertNil(date.changing(.minute, value: 70))
        XCTAssertNotNil(date.changing(.minute, value: 20))
        XCTAssertEqual(date.changing(.minute, value: 20)?.minute, 20)

        XCTAssertNil(date.changing(.hour, value: -2))
        XCTAssertNil(date.changing(.hour, value: 25))
        XCTAssertNotNil(date.changing(.hour, value: 6))
        XCTAssertEqual(date.changing(.hour, value: 6)?.hour, 6)

        XCTAssertNil(date.changing(.day, value: -2))
        XCTAssertNil(date.changing(.day, value: 35))
        XCTAssertNotNil(date.changing(.day, value: 6))
        XCTAssertEqual(date.changing(.day, value: 6)?.day, 6)

        XCTAssertNil(date.changing(.month, value: -2))
        XCTAssertNil(date.changing(.month, value: 13))
        XCTAssertNotNil(date.changing(.month, value: 6))
        XCTAssertEqual(date.changing(.month, value: 6)?.month, 6)

        XCTAssertNil(date.changing(.year, value: -2))
        XCTAssertNil(date.changing(.year, value: 0))
        XCTAssertNotNil(date.changing(.year, value: 2015))
        XCTAssertEqual(date.changing(.year, value: 2015)?.year, 2015)

        let date1 = Date()
        let date2 = date1.changing(.weekOfYear, value: 10)
        XCTAssertEqual(date2, Calendar.current.date(bySetting: .weekOfYear, value: 10, of: date1))
    }

    func testBeginning() {
        let date = Date()

        XCTAssertNotNil(date.beginning(of: .second))
        XCTAssertEqual(date.beginning(of: .second)?.nanosecond, 0)

        XCTAssertNotNil(date.beginning(of: .minute))
        XCTAssertEqual(date.beginning(of: .minute)?.second, 0)

        XCTAssertNotNil(date.beginning(of: .hour))
        XCTAssertEqual(date.beginning(of: .hour)?.minute, 0)

        XCTAssertNotNil(date.beginning(of: .day))
        XCTAssertEqual(date.beginning(of: .day)?.hour, 0)
        XCTAssertEqual(date.beginning(of: .day)?.isInToday, true)

        let comps = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        let beginningOfWeek = Calendar.current.date(from: comps)
        XCTAssertNotNil(date.beginning(of: .weekOfMonth))
        XCTAssertNotNil(beginningOfWeek)
        XCTAssertEqual(date.beginning(of: .weekOfMonth)?.day, beginningOfWeek?.day)

        let beginningOfMonth = Date(year: 2016, month: 8, day: 1, hour: 5)
        XCTAssertNotNil(date.beginning(of: .month))
        XCTAssertNotNil(beginningOfMonth)
        XCTAssertEqual(date.beginning(of: .month)?.day, beginningOfMonth?.day)

        let beginningOfYear = Date(year: 2016, month: 1, day: 1, hour: 5)
        XCTAssertNotNil(date.beginning(of: .year))
        XCTAssertNotNil(beginningOfYear)
        XCTAssertEqual(date.beginning(of: .year)?.day, beginningOfYear?.day)

        XCTAssertNil(date.beginning(of: .quarter))
    }

    func testEnd() {
        let date = Date(timeIntervalSince1970: 512) // January 1, 1970 at 2:08:32 AM GMT+2

        XCTAssertEqual(date.end(of: .second)?.second, 32)
        XCTAssertEqual(date.end(of: .hour)?.minute, 59)
        XCTAssertEqual(date.end(of: .minute)?.second, 59)

        XCTAssertEqual(date.end(of: .day)?.hour, 23)
        XCTAssertEqual(date.end(of: .day)?.minute, 59)
        XCTAssertEqual(date.end(of: .day)?.second, 59)

        var endOfWeek = date.beginning(of: .weekOfYear)
        endOfWeek?.add(.day, value: 7)
        endOfWeek?.add(.second, value: -1)
        XCTAssertEqual(date.end(of: .weekOfYear), endOfWeek)

        XCTAssertEqual(date.end(of: .month)?.day, 31)
        XCTAssertEqual(date.end(of: .month)?.hour, 23)
        XCTAssertEqual(date.end(of: .month)?.minute, 59)
        XCTAssertEqual(date.end(of: .month)?.second, 59)

        XCTAssertEqual(date.end(of: .year)?.month, 12)
        XCTAssertEqual(date.end(of: .year)?.day, 31)
        XCTAssertEqual(date.end(of: .year)?.hour, 23)
        XCTAssertEqual(date.end(of: .year)?.minute, 59)
        XCTAssertEqual(date.end(of: .year)?.second, 59)

        XCTAssertNil(date.end(of: .quarter))
    }

    func testDateString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()
        formatter.timeStyle = .none

        formatter.dateStyle = .short
        XCTAssertEqual(date.dateString(ofStyle: .short), formatter.string(from: date))

        formatter.dateStyle = .medium
        XCTAssertEqual(date.dateString(ofStyle: .medium), formatter.string(from: date))

        formatter.dateStyle = .long
        XCTAssertEqual(date.dateString(ofStyle: .long), formatter.string(from: date))

        formatter.dateStyle = .full
        XCTAssertEqual(date.dateString(ofStyle: .full), formatter.string(from: date))

        formatter.dateStyle = .none

        formatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual(date.string(withFormat: "dd/MM/yyyy"), formatter.string(from: date))

        formatter.dateFormat = "HH:mm"
        XCTAssertEqual(date.string(withFormat: "HH:mm"), formatter.string(from: date))

        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        XCTAssertEqual(date.string(withFormat: "dd/MM/yyyy HH:mm"), formatter.string(from: date))

        formatter.dateFormat = "iiiii"
        XCTAssertEqual(date.string(withFormat: "iiiii"), formatter.string(from: date))
    }

    func testDateTimeString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()

        formatter.timeStyle = .short
        formatter.dateStyle = .short
        XCTAssertEqual(date.dateTimeString(ofStyle: .short), formatter.string(from: date))

        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        XCTAssertEqual(date.dateTimeString(ofStyle: .medium), formatter.string(from: date))

        formatter.timeStyle = .long
        formatter.dateStyle = .long
        XCTAssertEqual(date.dateTimeString(ofStyle: .long), formatter.string(from: date))

        formatter.timeStyle = .full
        formatter.dateStyle = .full
        XCTAssertEqual(date.dateTimeString(ofStyle: .full), formatter.string(from: date))
    }

    func testIsInCurrent() {
        let date = Date()
        let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z

        XCTAssert(date.isInCurrent(.second))
        XCTAssertFalse(oldDate.isInCurrent(.second))

        XCTAssert(date.isInCurrent(.minute))
        XCTAssertFalse(oldDate.isInCurrent(.minute))

        XCTAssert(date.isInCurrent(.hour))
        XCTAssertFalse(oldDate.isInCurrent(.hour))

        XCTAssert(date.isInCurrent(.day))
        XCTAssertFalse(oldDate.isInCurrent(.day))

        XCTAssert(date.isInCurrent(.weekOfMonth))
        XCTAssertFalse(oldDate.isInCurrent(.weekOfMonth))

        XCTAssert(date.isInCurrent(.month))
        XCTAssertFalse(oldDate.isInCurrent(.month))

        XCTAssert(date.isInCurrent(.year))
        XCTAssertFalse(oldDate.isInCurrent(.year))

        XCTAssert(date.isInCurrent(.era))
    }

    func testTimeString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()
        formatter.dateStyle = .none

        formatter.timeStyle = .short
        XCTAssertEqual(date.timeString(ofStyle: .short), formatter.string(from: date))

        formatter.timeStyle = .medium
        XCTAssertEqual(date.timeString(ofStyle: .medium), formatter.string(from: date))

        formatter.timeStyle = .long
        XCTAssertEqual(date.timeString(ofStyle: .long), formatter.string(from: date))

        formatter.timeStyle = .full
        XCTAssertEqual(date.timeString(ofStyle: .full), formatter.string(from: date))
    }

    func testDayName() {
        let date = Date(timeIntervalSince1970: 1486121165)
        XCTAssertEqual(date.dayName(ofStyle: .full), "Friday")
        XCTAssertEqual(date.dayName(ofStyle: .threeLetters), "Fri")
        XCTAssertEqual(date.dayName(ofStyle: .oneLetter), "F")
    }

    func testMonthName() {
        let date = Date(timeIntervalSince1970: 1486121165)
        XCTAssertEqual(date.monthName(ofStyle: .full), "February")
        XCTAssertEqual(date.monthName(ofStyle: .threeLetters), "Feb")
        XCTAssertEqual(date.monthName(ofStyle: .oneLetter), "F")
    }

    func testSecondsSince() {
        let date1 = Date(timeIntervalSince1970: 100)
        let date2 = Date(timeIntervalSince1970: 180)
        XCTAssertEqual(date2.secondsSince(date1), 80)
        XCTAssertEqual(date1.secondsSince(date2), -80)
    }

    func testMinutesSince() {
        let date1 = Date(timeIntervalSince1970: 120)
        let date2 = Date(timeIntervalSince1970: 180)
        XCTAssertEqual(date2.minutesSince(date1), 1)
        XCTAssertEqual(date1.minutesSince(date2), -1)
    }

    func testHoursSince() {
        let date1 = Date(timeIntervalSince1970: 3600)
        let date2 = Date(timeIntervalSince1970: 7200)
        XCTAssertEqual(date2.hoursSince(date1), 1)
        XCTAssertEqual(date1.hoursSince(date2), -1)
    }

    func testDaysSince() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = Date(timeIntervalSince1970: 86400)
        XCTAssertEqual(date2.daysSince(date1), 1)
        XCTAssertEqual(date1.daysSince(date2), -1)
    }

    func testIsBetween() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = date1.addingTimeInterval(60)
        let date3 = date2.addingTimeInterval(60)

        XCTAssert(date2.isBetween(date1, date3))
        XCTAssertFalse(date1.isBetween(date2, date3))
        XCTAssert(date1.isBetween(date1, date2, includeBounds: true))
        XCTAssertFalse(date1.isBetween(date1, date2))
    }

    func testIsWithin() {
        let date1 = Date(timeIntervalSince1970: 60 * 60 * 24) // 1970-01-01T00:00:00.000Z
        let date2 = date1.addingTimeInterval(60 * 60) // 1970-01-01T00:01:00.000Z, one hour later than date1

        // The regular
        XCTAssertFalse(date1.isWithin(1, .second, of: date2))
        XCTAssertFalse(date1.isWithin(1, .minute, of: date2))
        XCTAssert(date1.isWithin(1, .hour, of: date2))
        XCTAssert(date1.isWithin(1, .day, of: date2))

        // The other way around
        XCTAssertFalse(date2.isWithin(1, .second, of: date1))
        XCTAssertFalse(date2.isWithin(1, .minute, of: date1))
        XCTAssert(date2.isWithin(1, .hour, of: date1))
        XCTAssert(date2.isWithin(1, .day, of: date1))

        // With itself
        XCTAssert(date1.isWithin(1, .second, of: date1))
        XCTAssert(date1.isWithin(1, .minute, of: date1))
        XCTAssert(date1.isWithin(1, .hour, of: date1))
        XCTAssert(date1.isWithin(1, .day, of: date1))

        // Invalid
        XCTAssertFalse(Date().isWithin(1, .calendar, of: Date()))
    }

    func testNewDateFromComponenets() {
        let date = Date(calendar: Date().calendar, timeZone: NSTimeZone.default, era: Date().era, year: Date().year, month: Date().month, day: Date().day, hour: Date().hour, minute: Date().minute, second: Date().second, nanosecond: Date().nanosecond)
        XCTAssertNotNil(date)
        let date1 = Date(timeIntervalSince1970: date!.timeIntervalSince1970)

        XCTAssertEqual(date?.timeIntervalSince1970, date1.timeIntervalSince1970)

        let date2 = Date(calendar: nil, timeZone: NSTimeZone.default, era: Date().era, year: nil, month: nil, day: Date().day, hour: Date().hour, minute: Date().minute, second: Date().second, nanosecond: Date().nanosecond)
        XCTAssertNil(date2)
    }

    func testNewDateFromIso8601String() {
        let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        let dateFromIso8601 = Date(iso8601String: "1970-01-01T00:08:32.000Z")
        XCTAssertEqual(date, dateFromIso8601)
        XCTAssertNil(Date(iso8601String: "hello"))
    }

    func testNewDateFromUnixTimestamp() {
        let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
        let dateFromUnixTimestamp = Date(unixTimestamp: 512)
        XCTAssertEqual(date, dateFromUnixTimestamp)
    }

    func testNewDateFromIntegerLiteral() {
        let date = Date(integerLiteral: 2017_12_25)

        XCTAssertNotNil(date)

        if let date = date {
            XCTAssertEqual(String(describing: date), "2017-12-25 00:00:00 +0000")
        }

        XCTAssertNil(Date(integerLiteral: 222))
    }

    func testRandomRange() {
        var sinceDate = Date(timeIntervalSinceReferenceDate: 0)
        var toDate = Date(timeIntervalSinceReferenceDate: 10000)
        XCTAssert(Date.random(in: sinceDate..<toDate).isBetween(sinceDate, toDate, includeBounds: false))

        sinceDate = Date(timeIntervalSince1970: -10000)
        toDate = Date(timeIntervalSince1970: -10)
        XCTAssert(Date.random(in: sinceDate..<toDate).isBetween(sinceDate, toDate, includeBounds: false))

        sinceDate = Date(timeIntervalSinceReferenceDate: -1000)
        toDate = Date(timeIntervalSinceReferenceDate: 10000)
        XCTAssert(Date.random(in: sinceDate..<toDate).isBetween(sinceDate, toDate, includeBounds: false))

        sinceDate = Date.distantPast
        toDate = Date.distantFuture
        XCTAssert(Date.random(in: sinceDate..<toDate).isBetween(sinceDate, toDate, includeBounds: false))
    }

    func testRandomClosedRange() {
        var sinceDate = Date(timeIntervalSinceReferenceDate: 0)
        var toDate = Date(timeIntervalSinceReferenceDate: 10000)
        XCTAssert(Date.random(in: sinceDate...toDate).isBetween(sinceDate, toDate, includeBounds: true))

        sinceDate = Date(timeIntervalSince1970: -10000)
        toDate = Date(timeIntervalSince1970: -10)
        XCTAssert(Date.random(in: sinceDate...toDate).isBetween(sinceDate, toDate, includeBounds: true))

        sinceDate = Date(timeIntervalSinceReferenceDate: -1000)
        toDate = Date(timeIntervalSinceReferenceDate: 10000)
        XCTAssert(Date.random(in: sinceDate...toDate).isBetween(sinceDate, toDate, includeBounds: true))

        sinceDate = Date.distantPast
        toDate = Date.distantFuture
        XCTAssert(Date.random(in: sinceDate...toDate).isBetween(sinceDate, toDate, includeBounds: true))

        let singleDate = Date(timeIntervalSinceReferenceDate: 0)
        XCTAssertFalse(Date.random(in: singleDate...singleDate).isBetween(singleDate, singleDate, includeBounds: false))
        XCTAssert(Date.random(in: singleDate...singleDate).isBetween(singleDate, singleDate, includeBounds: true))
    }

    func testRandomRangeWithGenerator() {
        var generator = SystemRandomNumberGenerator()
        let sinceDate = Date.distantPast
        let toDate = Date.distantFuture
        XCTAssert(Date.random(in: sinceDate..<toDate, using: &generator).isBetween(sinceDate, toDate, includeBounds: false))
    }

    func testRandomClosedRangeWithGenerator() {
        var generator = SystemRandomNumberGenerator()
        let sinceDate = Date.distantPast
        let toDate = Date.distantFuture
        XCTAssert(Date.random(in: sinceDate...toDate, using: &generator).isBetween(sinceDate, toDate, includeBounds: true))

        let singleDate = Date(timeIntervalSinceReferenceDate: 0)
        XCTAssertFalse(Date.random(in: singleDate...singleDate, using: &generator).isBetween(singleDate, singleDate, includeBounds: false))
        XCTAssert(Date.random(in: singleDate...singleDate, using: &generator).isBetween(singleDate, singleDate, includeBounds: true))
    }

    func testYesterday() {
        let date = Date()
        XCTAssertEqual(date.yesterday.timeIntervalSince(date), -86400.0)
    }

    func testTomorrow() {
        let date = Date()
        XCTAssertEqual(date.tomorrow.timeIntervalSince(date), 86400.0)
    }
}

#endif
