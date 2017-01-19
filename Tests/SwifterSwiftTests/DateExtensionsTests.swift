//
//  DateExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class DateExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		NSTimeZone.default = TimeZone(abbreviation: "UTC")!
	}
	
	func testAdd() {
		var date = Date()
		
		date.second = 10
		date.add(.second, value: -1)
		XCTAssertEqual(date.second, 9)
		
		date.add(.second, value: 1)
		XCTAssertEqual(date.second, 10)
		
		date.minute = 10
		date.add(.minute, value: -1)
		XCTAssertEqual(date.minute, 9)
		
		date.add(.minute, value: 1)
		XCTAssertEqual(date.minute, 10)
		
		date.hour = 10
		date.add(.hour, value: -1)
		XCTAssertEqual(date.hour, 9)
		
		date.add(.hour, value: 1)
		XCTAssertEqual(date.hour, 10)
		
		date.day = 10
		date.add(.day, value: -1)
		XCTAssertEqual(date.day, 9)
		
		date.add(.day, value: 1)
		XCTAssertEqual(date.day, 10)
		
		date.month = 10
		date.add(.month, value: -1)
		XCTAssertEqual(date.month, 9)
		
		date.add(.month, value: 1)
		XCTAssertEqual(date.month, 10)
		
		date.year = 2016
		date.add(.year, value: -1)
		XCTAssertEqual(date.year, 2015)
		
		date.add(.year, value: 1)
		XCTAssertEqual(date.year, 2016)
	}
	
	func testBeginning() {
		let date = Date()

		XCTAssertNotNil(date.beginning(of: .second))
		XCTAssertEqual(date.beginning(of: .second)!.nanosecond, 0)
		
		XCTAssertNotNil(date.beginning(of: .minute))
		XCTAssertEqual(date.beginning(of: .minute)!.second, 0)
		
		XCTAssertNotNil(date.beginning(of: .hour))
		XCTAssertEqual(date.beginning(of: .hour)!.minute, 0)
		
		XCTAssertNotNil(date.beginning(of: .day))
		XCTAssertEqual(date.beginning(of: .day)!.hour, 0)
		XCTAssertTrue(date.beginning(of: .day)!.isInToday)
		
		let beginningOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
		XCTAssertNotNil(date.beginning(of: .weekOfMonth))
		XCTAssertNotNil(beginningOfWeek)
		XCTAssertEqual(date.beginning(of: .weekOfMonth)!.day, beginningOfWeek!.day)
		
		let beginningOfMonth = Date(year: 2016, month: 8, day: 1)
		XCTAssertNotNil(date.beginning(of: .month))
		XCTAssertNotNil(beginningOfMonth)
		XCTAssertEqual(date.beginning(of: .month)!.day, beginningOfMonth!.day)
		
		let beginningOfYear = Date(year: 2016, month: 1, day: 1)
		XCTAssertNotNil(date.beginning(of: .year))
		XCTAssertNotNil(beginningOfYear)
		XCTAssertEqual(date.beginning(of: .year)!.day, beginningOfYear!.day)
	}
	
	func testCalendar() {
		XCTAssertEqual(Date().calendar, Calendar.current)
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
	
	func testDay() {
		var date = Date()
		XCTAssertEqual(date.day, Calendar.current.component(.day, from: date))
		
		date.day = 4
		XCTAssertEqual(date.day, Calendar.current.component(.day, from: date))
	}
	
	func testEnd() {
		let date = Date(timeIntervalSince1970: 512) // January 1, 1970 at 2:08:32 AM GMT+2
		
		XCTAssertEqual(date.end(of: .second)!.second , 32)
		XCTAssertEqual(date.end(of: .hour)!.minute, 59)
		XCTAssertEqual(date.end(of: .minute)!.second, 59)
		
		XCTAssertEqual(date.end(of: .day)!.hour, 23)
		XCTAssertEqual(date.end(of: .day)!.minute, 59)
		XCTAssertEqual(date.end(of: .day)!.second, 59)

		var endOfWeek = date.beginning(of: .weekOfYear)
		endOfWeek!.add(.day, value: 7)
		endOfWeek!.add(.second, value: -1)
		XCTAssertEqual(date.end(of: .weekOfYear), endOfWeek)
		
		XCTAssertEqual(date.end(of: .month)!.day, 31)
		XCTAssertEqual(date.end(of: .month)!.hour, 23)
		XCTAssertEqual(date.end(of: .month)!.minute, 59)
		XCTAssertEqual(date.end(of: .month)!.second, 59)
		
		XCTAssertEqual(date.end(of: .year)!.month, 12)
		XCTAssertEqual(date.end(of: .year)!.day, 31)
		XCTAssertEqual(date.end(of: .year)!.hour, 23)
		XCTAssertEqual(date.end(of: .year)!.minute, 59)
		XCTAssertEqual(date.end(of: .year)!.second, 59)

	}
	
	func testEra() {
		XCTAssertEqual(Date().era, Calendar.current.component(.era, from: Date()))
	}
	
	func testHour() {
		var date = Date()
		XCTAssertEqual(date.hour, Calendar.current.component(.hour, from: date))
		
		date.hour = 4
		XCTAssertEqual(date.hour, Calendar.current.component(.hour, from: date))
	}
	
	func testNewDateFromComponenets() {
		let date = Date(calendar: Date().calendar, timeZone: Date().timeZone, era: Date().era, year: Date().year, month: Date().month, day: Date().day, hour: Date().hour, minute: Date().minute, second: Date().second, nanosecond: Date().nanosecond) ?? Date()
		let date1 = Date(timeIntervalSince1970: date.timeIntervalSince1970)
		
		XCTAssertEqual(date.timeIntervalSince1970, date1.timeIntervalSince1970)
	}
	
	func testNewDateFromIso8601String() {
		let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let dateFromIso8601 = Date(iso8601String: "1970-01-01T00:08:32.000Z")
		XCTAssertEqual(date, dateFromIso8601)
	}
	
	func testNewDateFromUnixTimestamp() {
		let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let dateFromUnixTimestamp = Date(unixTimestamp: 512)
		XCTAssertEqual(date, dateFromUnixTimestamp)
	}
	
	func testIsInCurrent() {
		let date = Date()
		let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		
		XCTAssertTrue(date.isInCurrent(.second))
		XCTAssertFalse(oldDate.isInCurrent(.second))
		
		XCTAssertTrue(date.isInCurrent(.minute))
		XCTAssertFalse(oldDate.isInCurrent(.minute))
		
		XCTAssertTrue(date.isInCurrent(.hour))
		XCTAssertFalse(oldDate.isInCurrent(.hour))
		
		XCTAssertTrue(date.isInCurrent(.day))
		XCTAssertFalse(oldDate.isInCurrent(.day))
		
		XCTAssertTrue(date.isInCurrent(.weekOfMonth))
		XCTAssertFalse(oldDate.isInCurrent(.weekOfMonth))
		
		XCTAssertTrue(date.isInCurrent(.month))
		XCTAssertFalse(oldDate.isInCurrent(.month))
		
		XCTAssertTrue(date.isInCurrent(.year))
		XCTAssertFalse(oldDate.isInCurrent(.year))
	}
	
	func testIsInFuture() {
		let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let futureDate = Date(timeIntervalSinceNow: 512)
		
		XCTAssertTrue(futureDate.isInFuture)
		XCTAssertFalse(oldDate.isInFuture)
	}
	
	func testIsInPast() {
		let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let futureDate = Date(timeIntervalSinceNow: 512)
		
		XCTAssertTrue(oldDate.isInPast)
		XCTAssertFalse(futureDate.isInPast)
	}
	
	func testIso8601String() {
		let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		XCTAssertEqual(date.iso8601String, "1970-01-01T00:08:32.000Z")
	}
	
	func testMinute() {
		var date = Date()
		XCTAssertEqual(date.minute, Calendar.current.component(.minute, from: Date()))
		
		date.minute = 13
		XCTAssertEqual(date.minute, Calendar.current.component(.minute, from: date))
		XCTAssertEqual(date.minute, 13)
	}
	
	func testMonth() {
		var date = Date()
		XCTAssertEqual(date.month, Calendar.current.component(.month, from: date))
		
		date.month = 3
		XCTAssertEqual(date.month, Calendar.current.component(.month, from: date))
		XCTAssertEqual(date.month, 3)
	}
	
	func testNanosecond() {
		let date = Date()
		XCTAssertEqual(date.nanosecond, Calendar.current.component(.nanosecond, from: date))
	}
	
	func testQuarter() {
		XCTAssertEqual(Date().quarter, Calendar.current.component(.quarter, from: Date()))
	}
	
	func testSecond() {
		var date = Date()
		XCTAssertEqual(date.second, Calendar.current.component(.second, from: date))
		
		date.second = 12
		XCTAssertEqual(date.second, Calendar.current.component(.second, from: date))
		XCTAssertEqual(date.second, 12)
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
	
	func testUnixTimestamp() {
		let date = Date()
		XCTAssertEqual(date.unixTimestamp, date.timeIntervalSince1970)
	}
	
	func testWeekday() {
		XCTAssertEqual(Date().weekday, Calendar.current.component(.weekday, from: Date()))
	}
	
	func testWeekOfMonth() {
		XCTAssertEqual(Date().weekOfMonth, Calendar.current.component(.weekOfMonth, from: Date()))
	}
	
	func testWeekOfYear() {
		XCTAssertEqual(Date().weekOfYear, Calendar.current.component(.weekOfYear, from: Date()))
	}
	
	func testYear() {
		var date = Date()
		XCTAssertEqual(date.year, Calendar.current.component(.year, from: date))
		
		date.year = 2000
		XCTAssertEqual(date.year, Calendar.current.component(.year, from: date))
		XCTAssertEqual(date.year, 2000)
	}
}
