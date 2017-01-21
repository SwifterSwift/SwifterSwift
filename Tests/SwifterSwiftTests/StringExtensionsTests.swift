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
		XCTAssertEqual("SGVsbG8gV29ybGQh".base64Decoded, "Hello World!")
	}
	
	func testBase64Encoded() {
		XCTAssertEqual("Hello World!".base64Encoded, "SGVsbG8gV29ybGQh")
	}
	
	func testCamelCased() {
		XCTAssertEqual("Hello test".camelCased, "helloTest")
	}
	
	func testCamelize() {
		var str = "Hello test"
		str.camelize()
		XCTAssertEqual(str, "helloTest")
	}
	
	func testContain() {
		XCTAssert("Hello Tests".contain("Hello"))
		XCTAssert("Hello Tests".contain("hello", caseSensitive: false))
	}
	
	func testContainEmoji() {
		XCTAssert("Hello 😂".containEmoji)
		XCTAssertFalse("Hello ;)".containEmoji)
	}
	
	func testCount() {
		XCTAssertEqual("Hello This Tests".count(of: "T"), 2)
		XCTAssertEqual("Hello This Tests".count(of: "t"), 1)
		XCTAssertEqual("Hello This Tests".count(of: "T", caseSensitive: false) , 3)
		XCTAssertEqual("Hello This Tests".count(of: "t", caseSensitive: false), 3)
        
	}
	
	func testEnd() {
		XCTAssert("Hello Tests".end(with: "sts"))
	}
	
	func testFirstCharacter() {
		XCTAssertNotNil("Hello".firstCharacter)
		XCTAssertEqual("Hello".firstCharacter!, "H")
	}
	
	func testFirstIndex() {
		XCTAssertEqual("Hello Test".firstIndex(of: "e"), 1)
	}
	
	func testHasLetters() {
		XCTAssert("hsj 1 wq3".hasLetters)
		XCTAssertFalse("123".hasLetters)
		XCTAssert("Hello test".hasLetters)
	}
	
	func testHasNumbers() {
		XCTAssert("hsj 1 wq3".hasNumbers)
		XCTAssert("123".hasNumbers)
		XCTAssertFalse("Hello test".hasNumbers)
	}
	
	func testIsAlphabetic() {
		XCTAssert("abc".isAlphabetic)
		XCTAssertFalse("123abc".isAlphabetic)
		XCTAssertFalse("123".isAlphabetic)
	}
	
	func testIsAlphaNumeric() {
		XCTAssert("123abc".isAlphaNumeric)
		XCTAssertFalse("123".isAlphaNumeric)
		XCTAssertFalse("abc".isAlphaNumeric)
	}
	
	func testIsEmail() {
		XCTAssert("omaralbeik@gmail.com".isEmail)
		XCTAssertFalse("omaralbeik@gmailcom".isEmail)
		XCTAssertFalse("omaralbeikgmail.com".isEmail)
	}
	
	func testIsValidUrl() {
		XCTAssert("https://google.com".isValidUrl)
		XCTAssert("http://google.com".isValidUrl)
		XCTAssert("ftp://google.com".isValidUrl)
	}
	
        func testIsValidSchemedUrl() {
                XCTAssert("https://google.com".isValidSchemedUrl)
                XCTAssert("ftp://google.com".isValidSchemedUrl)
                XCTAssertFalse("google.com".isValidSchemedUrl)
        }
    
	func testIsValidHttpsUrl() {
		XCTAssert("https://google.com".isValidHttpsUrl)
		XCTAssertFalse("http://google.com".isValidHttpsUrl)
		XCTAssertFalse("google.com".isValidHttpsUrl)
	}
	
	func testIsValidHttpUrl() {
		XCTAssert("http://google.com".isValidHttpUrl)
		XCTAssertFalse("google.com".isValidHttpUrl)
	}
	
	func testIsNumeric() {
		XCTAssert("123".isNumeric)
		XCTAssertFalse("123abc".isNumeric)
		XCTAssertFalse("abc".isNumeric)
	}
	
	func testLastCharacter() {
		XCTAssertNotNil("Hello".lastCharacter)
		XCTAssertEqual("Hello".lastCharacter!, "o")
	}
	
	func testLatinize() {
		var str = "Hëllô Teśt"
		str.latinize()
		XCTAssertEqual(str, "Hello Test")
	}
	
	func testLatinized() {
		XCTAssertEqual("Hëllô Teśt".latinized, "Hello Test")
	}
	
	func testLines() {
		XCTAssertEqual("Hello\ntest".lines, ["Hello", "test"])
	}
	
	func testMostCommonCharacter() {
		let mostCommonCharacter = "This is a test, since e is appearing every where e should be the common character".mostCommonCharacter
		XCTAssertEqual(mostCommonCharacter, "e")
	}
	
	func testRandom() {
		XCTAssertEqual(String.random(ofLength: 10).characters.count, 10)
	}
	
	func testReplace() {
		XCTAssertEqual("Hello Test".replacing("e", with: "a"), "Hallo Tast")
	}
	
	func testReverse() {
		var str = "Hello"
		str.reverse()
		XCTAssertEqual(str, "olleH")
	}
	
	func testReversed() {
		XCTAssertEqual("Hello".reversed, "olleH")
	}

	func testSlice() {
		XCTAssertEqual("12345678".slicing(from: 2, length: 3)!, "345")
		XCTAssertEqual("12345678".slicing(from: 2, length: 3)!, "345")
		XCTAssertEqual("12345678".slicing(from: 2, length: 0)!, "")
		XCTAssertNil("12345678".slicing(from: 12, length: 0))
		XCTAssertEqual("12345678".slicing(from: 2, length: 100), "345678")
		XCTAssertEqual("12345678".slicing(from: 2, to: 5), "345")
		XCTAssertNil("12345678".slicing(from: 2, to: 1))
		XCTAssertEqual("12345678".slicing(at: 2)!, "345678")
	}

	func testSplit() {
		XCTAssertEqual("Hello Tests".splitted(by: " "), ["Hello", "Tests"])
	}
	
	func testStart() {
		XCTAssert("Hello Tests".start(with: "He"))
	}
	
	func testOperators() {
		let s = Character("s")
		XCTAssertEqual(s * 5, "sssss")
	}
	
	func testToBool() {
		XCTAssertNotNil("1".bool)
		XCTAssert("1".bool!)
		
		XCTAssertNotNil("false".bool)
		XCTAssertFalse("false".bool!)
		XCTAssertNil("8s".bool)
	}
	
	func testToDate() {
		let dateFromStr = "2015-06-01".date
		XCTAssertNotNil(dateFromStr)
		XCTAssertEqual(dateFromStr!.year, 2015)
		XCTAssertEqual(dateFromStr!.month, 6)
		XCTAssertEqual(dateFromStr!.day, 1)
	}
	
	func testToDateTime() {
		let dateFromStr = "2015-06-01 14:23:09".dateTime
		XCTAssertNotNil(dateFromStr)
		XCTAssertEqual(dateFromStr!.year, 2015)
		XCTAssertEqual(dateFromStr!.month, 6)
		XCTAssertEqual(dateFromStr!.day, 1)
		XCTAssertEqual(dateFromStr!.hour, 14)
		XCTAssertEqual(dateFromStr!.minute, 23)
		XCTAssertEqual(dateFromStr!.second, 9)
	}
	
	func testToDouble() {
		XCTAssertNotNil("8".double)
		XCTAssertEqual("8".double!, 8)
		
		XCTAssertNotNil("8.23".double)
		XCTAssertEqual("8.23".double!, 8.23)
		
		XCTAssertNil("8s".double)
	}
	
	func testToFloat() {
		XCTAssertNotNil("8".float)
		XCTAssertEqual("8".float!, 8)
		
		XCTAssertNotNil("8.23".float)
		XCTAssertEqual("8.23".float!, Float(8.23))
		
		XCTAssertNil("8s".float)
	}
	
	func testToInt() {
		XCTAssertNotNil("8".int)
		XCTAssertEqual("8".int!, 8)
		
		XCTAssertNil("8s".int)
	}
	
	func testTrim() {
		var str = "\n Hello \n "
		str.trim()
		XCTAssertEqual(str, "Hello")
	}
	
	func testTrimmed() {
		XCTAssertEqual("\n Hello \n ".trimmed, "Hello")
	}
	
	func testTruncate() {
		var str = "This is a very long sentence"
		str.truncate(toLength: 14)
		XCTAssertEqual(str, "This is a very...")
	}
	
	func testTruncated() {
		XCTAssertEqual("This is a very long sentence".truncated(toLength: 14), "This is a very...")
	}
	
	func testUnicodeArray() {
		XCTAssertEqual("Hello".unicodeArray, [72, 101, 108, 108, 111])
	}
	
	func testUrlDecode() {
		var url = "it's%20easy%20to%20encode%20strings"
		url.urlDecode()
		XCTAssertEqual(url, "it's easy to encode strings")
	}
	
	func testUrlDecoded() {
		XCTAssertEqual("it's%20easy%20to%20encode%20strings".urlDecoded, "it's easy to encode strings")
	}
	
	func testUrlEncode() {
		var url = "it's easy to encode strings"
		url.urlEncode()
		XCTAssertEqual(url, "it's%20easy%20to%20encode%20strings")
	}
	
	func testUrlEncoded() {
		XCTAssertEqual("it's easy to encode strings".urlEncoded, "it's%20easy%20to%20encode%20strings")
	}
	
	func testWithoutSpacesAndNewLines() {
		XCTAssertEqual("Hello \n Test".withoutSpacesAndNewLines, "HelloTest")
	}
}
