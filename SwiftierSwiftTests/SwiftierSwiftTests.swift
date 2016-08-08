//
//  SwiftierSwiftTests.swift
//  SwiftierSwiftTests
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class SwiftierSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    /*
    
    func testUITextFieldExtensions() {
        
        let textField = UITextField()
        XCTAssert(textField.isEmpty == true, "Could not get correct value for empty textField")
        
        textField.text = "Some Text"
        XCTAssert(textField.isEmpty == false, "Could not get correct value for an textField with text")
    }
    
    func testStringExtensions() {
        
        let text = "Hello Test"
        
        // count(of string: String) test
        XCTAssert(text.count(of: "e") == 2, "Could not get correct count of substring in a string")
        
        // contain(string: String) test
        XCTAssert(text.contains("Test") == true && text.contains("Another text") == false, "Could not get correct value occurrence of substring in a string")
        
        // end(with suffix: String) test
        XCTAssert(text.end(with: "Test") == true && text.end(with: "Hello") == false, "Could not get correct value for occurrence of substring in the end of a string")
        
        // start(with prefix: String) test
        XCTAssert(text.start(with: "Hello") == true && text.start(with: "Test") == false, "Could not get correct value for occurrence of substring in the beginning of a string")
        
        // split(by separator: Character)
        XCTAssert(text.split(by: " ") == ["Hello", "Test"], "Could not split string into strings array")
        
        // trimmed
        let text1 = " Test \n"
        XCTAssert(text1.trimmed == "Test", "Could not trimm string")
        
        // firstCharacter
        XCTAssert(text.firstCharacter == "H", "Could not get correct first character")
        
        // lastCharacter
        XCTAssert(text.lastCharacter == "t", "Could not get correct last character")
        
        // mostCommonCharacter
        let text2 = "This is some test"
        XCTAssert(text2.mostCommonCharacter == "s", "Could not get correct most common character")
        
        // isEmail
        let text3 = "omaralbeik@gmail.com"
        XCTAssert(text2.isEmail == false && text3.isEmail == true, "Could not get correct isEmail value")
        
        // reversed
        XCTAssert(text.reversed == "tseT olleH", "Could not get correct reversed value for a string")
        
        // firstIndex(of string: String)
        XCTAssert(text.firstIndex(of: "e") == 1, "Could not get first index of given substring in a string")
        
        // replace(string: String, with: String)
        XCTAssert(text.replace(string: "Hello", with: "Hi") == "Hi Test", "Could not replace a substring in a string")
    }
    
    func testDateExtensions() {
        
        let date = Date()
        
        // calendar
        XCTAssert(date.calendar == Calendar.current, "Could not get current calendar correctly")
        
        // timeZone
        XCTAssert(date.timeZone == TimeZone.current, "Could not get current time zone")
        
        // nanosecond
        XCTAssert(date.nanosecond == Calendar.current.component(.nanosecond, from: date), "Could not get correct nanosecond")
        
        // second
        XCTAssert(date.second == Calendar.current.component(.second, from: date), "Could not get correct second")
        
        var date1 = date
        date1.second = 12
        XCTAssert(date1.second == Calendar.current.component(.second, from: date1) && date1.second == 12, "Could not set seconds")
        
        // minute
        XCTAssert(date.minute == Calendar.current.component(.minute, from: date), "Could not get correct minutes")
        
        date1 = date
        date1.minute = 13
        XCTAssert(date1.minute == Calendar.current.component(.minute, from: date1) && date1.minute == 13, "Could not set minutes")
        
        // hours
        XCTAssert(date.hour == Calendar.current.component(.hour, from: date), "Could not get correct hours")
        
        date1 = date
        date1.hour = 4
        XCTAssert(date1.hour == Calendar.current.component(.hour, from: date1), "Could not set hours")
        
        // days
        XCTAssert(date.day == Calendar.current.component(.day, from: date) && date1.hour == 4, "Could not get correct day")
        
        date1 = date
        date1.day = 3
        XCTAssert(date1.day == Calendar.current.component(.day, from: date1) && date1.day == 3, "Could not set day")
        
        
        // weekday
        XCTAssert(date.weekday == Calendar.current.component(.weekday, from: date), "Could not get correct weekday")
        
        // weekOfMonth
        XCTAssert(date.weekOfMonth == Calendar.current.component(.weekOfMonth, from: date), "Could not get correct weekOfMonth")
        
        // weekOfYear
        XCTAssert(date.weekOfYear == Calendar.current.component(.weekOfYear, from: date), "Could not get correct weekOfYear")
        
        // month
        XCTAssert(date.month == Calendar.current.component(.month, from: date), "Could not get correct month")
        
        date1 = date
        date1.month = 3
        XCTAssert(date1.month == Calendar.current.component(.month, from: date1) && date1.month == 3, "Could not set month")
        
        // year
        XCTAssert(date.year == Calendar.current.component(.year, from: date), "Could not get correct year")
        
        date1 = date
        date1.year = 2000
        XCTAssert(date1.year == Calendar.current.component(.year, from: date1) && date1.year == 2000, "Could not set year")
        
        // era
        XCTAssert(date.era == Calendar.current.component(.era, from: date), "Could not get correct era")
        
        // quarter
        XCTAssert(date.quarter == Calendar.current.component(.quarter, from: date), "Could not get correct quarter")
        
        // isInToday
        XCTAssert(date.isInToday == true, "Could not get true for today from isInToday")
        date1 = Date()
        date1.day -= 1
        XCTAssert(date1.isInToday == false, "Could not get false for yesterday from isInToday")
        
        
        // add(component: Calendar.Component, value: Int)
        date1.second = 10
        date1.add(component: .second, value: -1)
        XCTAssert(date1.second == 9, "Could not substract seconds")
        
        date1.add(component: .second, value: 1)
        XCTAssert(date1.second == 10, "Could not add seconds")
        
        
        date1.minute = 10
        date1.add(component: .minute, value: -1)
        XCTAssert(date1.minute == 9, "Could not substract minutes")
        
        date1.add(component: .minute, value: 1)
        XCTAssert(date1.minute == 10, "Could not add minutes")
        
        
        date1.hour = 10
        date1.add(component: .hour, value: -1)
        XCTAssert(date1.hour == 9, "Could not substract hours")
        
        date1.add(component: .hour, value: 1)
        XCTAssert(date1.hour == 10, "Could not add hours")
        
        
        date1.day = 10
        date1.add(component: .day, value: -1)
        XCTAssert(date1.day == 9, "Could not substract days")
        
        date1.add(component: .day, value: 1)
        XCTAssert(date1.day == 10, "Could not add days")
        
        
        date1.month = 10
        date1.add(component: .month, value: -1)
        XCTAssert(date1.month == 9, "Could not substract months")
        
        date1.add(component: .month, value: 1)
        XCTAssert(date1.month == 10, "Could not add months")
        
        date1.year = 2016
        date1.add(component: .year, value: -1)
        XCTAssert(date1.year == 2015, "Could not substract years")
        
        date1.add(component: .year, value: 1)
        XCTAssert(date1.year == 2016, "Could not add years")
        
        
        // beginning(of component: Calendar.Component)
        XCTAssert(Date().beginning(of: .second).nanosecond == 0, "Could not get correct beginning of seconds")
        XCTAssert(Date().beginning(of: .minute).second == 0, "Could not get correct beginning of minutes")
        XCTAssert(Date().beginning(of: .hour).minute == 0, "Could not get correct beginning of hours")

    }
    
    override func tearDown() {
        super.tearDown()
    }
 
 */
    
}
