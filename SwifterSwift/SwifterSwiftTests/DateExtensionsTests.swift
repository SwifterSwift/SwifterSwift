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
		var date1 = Date()
		
		date1.second = 10
		date1.add(.second, value: -1)
		XCTAssert(date1.second == 9, "Could not substract seconds in \(#function)")
		
		date1.add(.second, value: 1)
		XCTAssert(date1.second == 10, "Could not add seconds in \(#function)")
		
		date1.minute = 10
		date1.add(.minute, value: -1)
		XCTAssert(date1.minute == 9, "Could not substract minutes in \(#function)")
		
		date1.add(.minute, value: 1)
		XCTAssert(date1.minute == 10, "Could not add minutes in \(#function)")
		
		date1.hour = 10
		date1.add(.hour, value: -1)
		XCTAssert(date1.hour == 9, "Could not substract hours in \(#function)")
		
		date1.add(.hour, value: 1)
		XCTAssert(date1.hour == 10, "Could not add hours in \(#function)")
		
		date1.day = 10
		date1.add(.day, value: -1)
		XCTAssert(date1.day == 9, "Could not substract days in \(#function)")
		
		date1.add(.day, value: 1)
		XCTAssert(date1.day == 10, "Could not add days in \(#function)")
		
		date1.month = 10
		date1.add(.month, value: -1)
		XCTAssert(date1.month == 9, "Could not substract months in \(#function)")
		
		date1.add(.month, value: 1)
		XCTAssert(date1.month == 10, "Could not add months in \(#function)")
		
		date1.year = 2016
		date1.add(.year, value: -1)
		XCTAssert(date1.year == 2015, "Could not substract years in \(#function)")
		
		date1.add(.year, value: 1)
		XCTAssert(date1.year == 2016, "Could not add years in \(#function)")
	}
	
	func testBeginning() {
		XCTAssert(Date().beginning(of: .second)?.nanosecond == 0, "Could not get correct value for beginning of second in \(#function)")
		
		XCTAssert(Date().beginning(of: .minute)?.second == 0, "Could not get correct value for beginning of minute in \(#function)")
		
		XCTAssert(Date().beginning(of: .hour)?.minute == 0, "Could not get correct value for beginning of hour in \(#function)")
		
		XCTAssert(Date().beginning(of: .day)?.hour == 0 && (Date().beginning(of: .day)?.isInToday)!, "Could not get correct value for beginning of day in \(#function)")
		
		let date = Date(year: 2016, month: 8, day: 9) ?? Date()
		
		let beginningOfWeek = Date(year: 2016, month: 8, day: 7) ?? Date()
		XCTAssert(date.beginning(of: .weekOfMonth)?.day == beginningOfWeek.day, "Could not get correct value for beginning of week in \(#function)")
		
		let beginningOfMonth = Date(year: 2016, month: 8, day: 1) ?? Date()
		XCTAssert(Date().beginning(of: .month)?.day == beginningOfMonth.day, "Could not get correct value for beginning of month in \(#function)")
		
		let beginningOfYear = Date(year: 2016, month: 1, day: 1) ?? Date()
		XCTAssert(Date().beginning(of: .year)?.day == beginningOfYear.day, "Could not get correct value for beginning of year in \(#function)")
	}
	
	func testCalendar() {
		XCTAssert(Date().calendar == Calendar.current, "Couldn't get correct value for \(#function)")
	}
	
	func testDateString() {
		let date = Date(timeIntervalSince1970: 512)
		XCTAssert(date.dateString() == "Jan 1, 1970", "Couldn't get correct value for \(#function)")
		XCTAssert(date.dateString(ofStyle: .short) == "1/1/70", "Couldn't get correct value for \(#function)")
		XCTAssert(date.dateString(ofStyle: .long) == "January 1, 1970", "Couldn't get correct value for \(#function)")
	}
	
	func testDateTimeString() {
		let date = Date(timeIntervalSince1970: 512)
		XCTAssert(date.dateTimeString() == "Jan 1, 1970, 12:08:32 AM", "Couldn't get correct value for \(#function)")
		XCTAssert(date.dateTimeString(ofStyle: .short) == "1/1/70, 12:08 AM", "Couldn't get correct value for \(#function)")
		XCTAssert(date.dateTimeString(ofStyle: .long) == "January 1, 1970 at 12:08:32 AM GMT", "Couldn't get correct value for \(#function)")
	}
	
	func testDay() {
		XCTAssert(Date().day == Calendar.current.component(.day, from: Date()), "Couldn't get correct value for \(#function)")
		
		var date1 = Date()
		date1.day = 4
		XCTAssert(date1.day == Calendar.current.component(.day, from: date1), "Couldn't get correct value for \(#function)")
	}
	
	func testEnd() {
		let date = Date(timeIntervalSince1970: 512) // January 1, 1970 at 2:08:32 AM GMT+2
		XCTAssert(date.end(of: .second)?.second == 32, "Couldn't get correct value for \(#function)")
		
		XCTAssert(date.end(of: .minute)?.second == 59, "Couldn't get correct value for \(#function)")
		
		XCTAssert(date.end(of: .hour)?.minute == 59 && date.end(of: .hour)?.second == 59, "Couldn't get correct value for \(#function)")
		
		XCTAssert(date.end(of: .day)?.hour == 23 && date.end(of: .day)?.minute == 59 && date.end(of: .day)?.second == 59, "Couldn't get correct value for \(#function)")
		
		var endOfWeek = date.beginning(of: .weekOfYear)
		endOfWeek?.add(.day, value: 7)
		endOfWeek?.add(.second, value: -1)
		XCTAssert(date.end(of: .weekOfYear) == endOfWeek, "Couldn't get correct value for \(#function)")
		
		XCTAssert(date.end(of: .month)?.day == 31 && date.end(of: .month)?.hour == 23 && date.end(of: .month)?.minute == 59 && date.end(of: .month)?.second == 59, "Couldn't get correct value for \(#function)")
		
		XCTAssert(date.end(of: .year)?.month == 12 && date.end(of: .year)?.day == 31 && date.end(of: .year)?.hour == 23 && date.end(of: .year)?.minute == 59 && date.end(of: .year)?.second == 59, "Couldn't get correct value for \(#function)")
	}
	
	func testEra() {
		XCTAssert(Date().era == Calendar.current.component(.era, from: Date()), "Couldn't get correct value for \(#function)")
	}
	
	func testHour() {
		XCTAssert(Date().hour == Calendar.current.component(.hour, from: Date()), "Couldn't get correct value for \(#function)")
		
		var date1 = Date()
		date1.hour = 4
		XCTAssert(date1.hour == Calendar.current.component(.hour, from: date1), "Couldn't get correct value for \(#function)")
	}
	
	func testNewDateFromComponenets() {
		let date = Date(calendar: Date().calendar, timeZone: Date().timeZone, era: Date().era, year: Date().year, month: Date().month, day: Date().day, hour: Date().hour, minute: Date().minute, second: Date().second, nanosecond: Date().nanosecond) ?? Date()
		let date1 = Date(timeIntervalSince1970: date.timeIntervalSince1970)
		
		XCTAssert(date.timeIntervalSince1970 == date1.timeIntervalSince1970, "Could not get correct value for \(#function)")
	}
	
	func testNewDateFromIso8601String() {
		let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let dateFromIso8601 = Date(iso8601String: "1970-01-01T00:08:32.000Z")
		XCTAssert(date == dateFromIso8601, "Could not get correct value for \(#function)")
	}
	
	func testNewDateFromUnixTimestamp() {
		let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let dateFromUnixTimestamp = Date(unixTimestamp: 512)
		XCTAssert(date == dateFromUnixTimestamp, "Could not get correct value for \(#function)")
	}
	
	func testIsInCurrent() {
		let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		XCTAssert(oldDate.isInCurrent(.second) == false && Date().isInCurrent(.second) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.second) == false && Date().isInCurrent(.second) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.minute) == false && Date().isInCurrent(.minute) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.hour) == false && Date().isInCurrent(.hour) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.day) == false && Date().isInCurrent(.day) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.weekOfMonth) == false && Date().isInCurrent(.weekOfMonth) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.month) == false && Date().isInCurrent(.month) == true, "Could not get correct value for \(#function)")
		
		XCTAssert(oldDate.isInCurrent(.year) == false && Date().isInCurrent(.year) == true, "Could not get correct value for \(#function)")
	}
	
	func testIsInFuture() {
		let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let futureDate = Date(timeIntervalSinceNow: 512)
		XCTAssert(oldDate.isInFuture == false && futureDate.isInFuture == true, "Could not get correct value for \(#function)")
	}
	
	func testIsInPast() {
		let oldDate = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		let futureDate = Date(timeIntervalSinceNow: 512)
		XCTAssert(oldDate.isInPast == true && futureDate.isInPast == false, "Could not get correct value for \(#function)")
	}
	
	func testIso8601String() {
		let date = Date(timeIntervalSince1970: 512) // 1970-01-01T00:08:32.000Z
		XCTAssert(date.iso8601String == "1970-01-01T00:08:32.000Z", "Could not get correct value for \(#function)")
	}
	
	func testMinute() {
		XCTAssert(Date().minute == Calendar.current.component(.minute, from: Date()), "Couldn't get correct value for \(#function)")
		
		var date1 = Date()
		date1.minute = 13
		XCTAssert(date1.minute == Calendar.current.component(.minute, from: date1) && date1.minute == 13, "Couldn't get correct value for \(#function)")
	}
	
	func testMonth() {
		XCTAssert(Date().month == Calendar.current.component(.month, from: Date()), "Couldn't get correct value for \(#function)")
		
		var date1 = Date()
		date1.month = 3
		XCTAssert(date1.month == Calendar.current.component(.month, from: date1) && date1.month == 3, "Couldn't get correct value for \(#function)")
	}
	
	func testNanosecond() {
		let date = Date()
		XCTAssert(date.nanosecond == Calendar.current.component(.nanosecond, from: date), "Couldn't get correct value for \(#function)")
	}
	
	func testQuarter() {
		XCTAssert(Date().quarter == Calendar.current.component(.quarter, from: Date()), "Couldn't get correct value for \(#function)")
	}
	
	func testSecond() {
		XCTAssert(Date().second == Calendar.current.component(.second, from: Date()), "Couldn't get correct value for \(#function)")
		
		var date1 = Date()
		date1.second = 12
		XCTAssert(date1.second == Calendar.current.component(.second, from: date1) && date1.second == 12, "Couldn't get correct value for \(#function)")
	}
	
	func testTimeString() {
		let date = Date(timeIntervalSince1970: 512)
		XCTAssert(date.timeString() == "12:08:32 AM", "Couldn't get correct value for \(#function)")
		XCTAssert(date.timeString(ofStyle: .short) == "12:08 AM", "Couldn't get correct value for \(#function)")
		XCTAssert(date.timeString(ofStyle: .long) == "12:08:32 AM GMT", "Couldn't get correct value for \(#function)")
	}
	
	func testUnixTimestamp() {
		let date = Date()
		XCTAssert(date.unixTimestamp == date.timeIntervalSince1970, "Couldn't get correct value for \(#function)")
	}
	
	func testWeekday() {
		XCTAssert(Date().weekday == Calendar.current.component(.weekday, from: Date()), "Couldn't get correct value for \(#function)")
	}
	
	func testWeekOfMonth() {
		XCTAssert(Date().weekOfMonth == Calendar.current.component(.weekOfMonth, from: Date()), "Couldn't get correct value for \(#function)")
	}
	
	func testWeekOfYear() {
		XCTAssert(Date().weekOfYear == Calendar.current.component(.weekOfYear, from: Date()), "Couldn't get correct value for \(#function)")
	}
	
	func testYear() {
		XCTAssert(Date().year == Calendar.current.component(.year, from: Date()), "Couldn't get correct value for \(#function)")
		
		var date1 = Date()
		date1.year = 2000
		XCTAssert(date1.year == Calendar.current.component(.year, from: date1) && date1.year == 2000, "Couldn't get correct value for \(#function)")
	}
}
