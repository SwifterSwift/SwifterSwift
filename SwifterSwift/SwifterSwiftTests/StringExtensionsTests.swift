//
//  StringExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class StringExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		NSTimeZone.default = NSTimeZone.system
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testBase64Decoded() {
		XCTAssert("SGVsbG8gV29ybGQh".base64Decoded == "Hello World!", "Couldn't get correct value for \(#function)")
	}
	
	func testBase64Encoded() {
		XCTAssert("Hello World!".base64Encoded == "SGVsbG8gV29ybGQh", "Couldn't get correct value for \(#function)")
	}
	
	func testCamelCased() {
		XCTAssert("Hello test".camelCased == "helloTest", "Couldn't get correct value for \(#function) function")
	}
	
	func testCamelize() {
		var str = "Hello test"
		str.camelize()
		XCTAssert(str == "helloTest", "Couldn't get correct value for \(#function) function")
	}
	
	func testContain() {
		XCTAssert("Hello Tests".contain("Hello") == true, "Couldn't get correct value for \(#function)")
	}
	
	func testContainEmoji() {
		XCTAssert("Hello 😂".containEmoji == true, "Couldn't get correct value for \(#function)")
		XCTAssert("Hello ;)".containEmoji == false, "Couldn't get correct value for \(#function)")
	}
	
	func testCount() {
		XCTAssert("Hello Tests".count(of: "e") == 2, "Couldn't get correct value for \(#function)")
	}
	
	func testEnd() {
		XCTAssert("Hello Tests".end(with: "sts"), "Couldn't get correct value for \(#function)")
	}
	
	func testFirstCharacter() {
		guard let firstCharacter = "Hello".firstCharacter else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		XCTAssert(firstCharacter == "H", "Couldn't get correct value for \(#function) function")
	}
	
	func testFirstIndex() {
		XCTAssert("Hello Test".firstIndex(of: "e") == 1, "Couldn't get correct value for \(#function) function")
	}
	
	func testHasLetters() {
		XCTAssert("hsj 1 wq3".hasLetters == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("123".hasLetters == false, "Couldn't get correct value for \(#function) function")
		XCTAssert("Hello test".hasLetters == true, "Couldn't get correct value for \(#function) function")
	}
	
	func testHasNumbers() {
		XCTAssert("hsj 1 wq3".hasNumbers == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("123".hasNumbers == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("Hello test".hasNumbers == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testIsAlphabetic() {
		XCTAssert("abc".isAlphabetic == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("123abc".isAlphabetic == false, "Couldn't get correct value for \(#function) function")
		XCTAssert("123".isAlphabetic == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testIsAlphaNumeric() {
		XCTAssert("123abc".isAlphaNumeric == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("123".isAlphaNumeric == false, "Couldn't get correct value for \(#function) function")
		XCTAssert("abc".isAlphaNumeric == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testIsEmail() {
		XCTAssert("omaralbeik@gmail.com".isEmail == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("omaralbeik@gmailcom".isEmail == false, "Couldn't get correct value for \(#function) function")
		XCTAssert("omaralbeikgmail.com".isEmail == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testIsHttpsUrl() {
		XCTAssert("https://google.com".isHttpsUrl == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("http://google.com".isHttpsUrl == false, "Couldn't get correct value for \(#function) function")
		XCTAssert("google.com".isHttpsUrl == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testIsHttpUrl() {
		XCTAssert("http://google.com".isHttpUrl == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("google.com".isHttpUrl == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testIsNumeric() {
		XCTAssert("123".isNumeric == true, "Couldn't get correct value for \(#function) function")
		XCTAssert("123abc".isNumeric == false, "Couldn't get correct value for \(#function) function")
		XCTAssert("abc".isNumeric == false, "Couldn't get correct value for \(#function) function")
	}
	
	func testLastCharacter() {
		guard let lastCharacter = "Hello".lastCharacter else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		XCTAssert(lastCharacter == "o", "Couldn't get correct value for \(#function) function")
	}
	
	func testLatinize() {
		var str = "Hëllô Teśt"
		str.latinize()
		XCTAssert(str == "Hello Test", "Couldn't get correct value for \(#function) function")
	}
	
	func testLatinized() {
		XCTAssert("Hëllô Teśt".latinized == "Hello Test", "Couldn't get correct value for \(#function) function")
	}
	
	func testLines() {
		XCTAssert("Hello\ntest".lines == ["Hello", "test"], "Couldn't get correct value for \(#function) function")
	}
	
	func testMostCommonCharacter() {
		let mostCommonCharacter = "This is a test, since e is appearing every where e should be the common character".mostCommonCharacter
		XCTAssert(mostCommonCharacter == "e", "Couldn't get correct value for \(#function) function")
	}
	
	func testRandom() {
		XCTAssert(String.random(ofLength: 10).characters.count == 10, "Couldn't get correct value for \(#function) function")
	}
	
	func testReplace() {
		XCTAssert("Hello Test".replacing("e", with: "a") == "Hallo Tast", "Couldn't get correct value for \(#function) function")
	}
	
	func testReverse() {
		var str = "Hello"
		str.reverse()
		XCTAssert(str == "olleH", "Couldn't get correct value for \(#function) function")
	}
	
	func testReversed() {
		XCTAssert("Hello".reversed == "olleH", "Couldn't get correct value for \(#function) function")
	}
	
	func testSplit() {
		XCTAssert("Hello Tests".splited(by: " ") == ["Hello", "Tests"], "Couldn't get correct value for \(#function)")
	}
	
	func testStart() {
		XCTAssert("Hello Tests".start(with: "He"), "Couldn't get correct value for \(#function)")
	}
	
	func testOperators() {
		let s = Character("s")
		XCTAssert(s * 5 == "sssss", "Couldn't get correct value for \(#function)")
	}
	
	func testToBool() {
		guard let num = "1".bool, num == true else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard let num2 = "false".bool, num2 == false else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard "8s".bool == nil else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
	}
	
	func testToDate() {
		let dateFromStr = "2015-06-01".date
		let year = dateFromStr?.year
		let month = dateFromStr?.month
		let day = dateFromStr?.day
		XCTAssert(year == 2015 && month == 6 && day == 1, "Couldn't get correct value for \(#function) function")
	}
	
	func testToDateTime() {
		let dateFromStr = "2015-06-01 14:23:09".dateTime
		let year = dateFromStr?.year
		let month = dateFromStr?.month
		let day = dateFromStr?.day
		let hour = dateFromStr?.hour
		let minute = dateFromStr?.minute
		let second = dateFromStr?.second
		XCTAssert(year == 2015 && month == 6 && day == 1 && hour == 14 && minute == 23 && second == 9, "Couldn't get correct value for \(#function) function")
	}
	
	func testToDouble() {
		guard let num = "8".double, num == 8 else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard let num2 = "8.23".double, num2 == 8.23 else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard "8s".double == nil else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
	}
	
	func testToFloat() {
		guard let num = "8".float, num == 8 else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard let num2 = "8.23".float, num2 == 8.23 else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard "8s".float == nil else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
	}
	
	func testToInt() {
		guard let num = "8".int, num == 8 else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
		guard "8s".int == nil else {
			XCTAssert(false, "Couldn't get correct value for \(#function) function")
			return
		}
	}
	
	func testTrim() {
		var str = "\n Hello \n "
		str.trim()
		XCTAssert(str == "Hello", "Couldn't get correct value for \(#function) function")
	}
	
	func testTrimmed() {
		XCTAssert("\n Hello \n ".trimmed == "Hello", "Couldn't get correct value for \(#function) function")
	}
	
	func testTruncate() {
		var str = "This is a very long sentence"
		str.truncate(toLength: 14)
		XCTAssert(str == "This is a very...", "Couldn't get correct value for \(#function) function")
	}
	
	func testTruncated() {
		XCTAssert("This is a very long sentence".truncated(toLength: 14) == "This is a very...", "Couldn't get correct value for \(#function) function")
	}
	
	func testUnicodeArray() {
		print("Hello".unicodeArray)
		XCTAssert("Hello".unicodeArray == [72, 101, 108, 108, 111], "Couldn't get correct value for \(#function) function")
	}
	
	func testUrlDecode() {
		var url = "it's%20easy%20to%20encode%20strings"
		url.urlDecode()
		XCTAssert(url == "it's easy to encode strings", "Couldn't get correct value for \(#function) function")
	}
	
	func testUrlDecoded() {
		XCTAssert("it's%20easy%20to%20encode%20strings".urlDecoded == "it's easy to encode strings", "Couldn't get correct value for \(#function) function")
	}
	
	func testUrlEncode() {
		var url = "it's easy to encode strings"
		url.urlEncode()
		XCTAssert(url == "it's%20easy%20to%20encode%20strings", "Couldn't get correct value for \(#function) function")
	}
	
	func testUrlEncoded() {
		XCTAssert("it's easy to encode strings".urlEncoded == "it's%20easy%20to%20encode%20strings", "Couldn't get correct value for \(#function) function")
	}
	
	func testWithoutSpacesAndNewLines() {
		XCTAssert("Hello \n Test".withoutSpacesAndNewLines == "HelloTest", "Couldn't get correct value for \(#function) function")
	}
}
