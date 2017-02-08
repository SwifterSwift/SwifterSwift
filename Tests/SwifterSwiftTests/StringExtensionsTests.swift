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
		XCTAssertNil("hello".base64Decoded)
	}
	
	func testBase64Encoded() {
		XCTAssertEqual("Hello World!".base64Encoded, "SGVsbG8gV29ybGQh")
	}
	
	func testCamelCased() {
		XCTAssertEqual("Hello test".camelCased, "helloTest")
		XCTAssertEqual("Hellotest".camelCased, "hellotest")
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
		XCTAssert("Hello Test".end(with: "test", caseSensitive: false))
		XCTAssert("Hello Tests".end(with: "sts"))
	}
	
	func testFirstCharacter() {
		XCTAssertNil("".firstCharacter)
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
		XCTAssertFalse("hello world!".isValidSchemedUrl)
		XCTAssert("https://google.com".isValidSchemedUrl)
		XCTAssert("ftp://google.com".isValidSchemedUrl)
		XCTAssertFalse("google.com".isValidSchemedUrl)
	}
	
	func testIsValidHttpsUrl() {
		XCTAssertFalse("hello world!".isValidHttpsUrl)
		XCTAssert("https://google.com".isValidHttpsUrl)
		XCTAssertFalse("http://google.com".isValidHttpsUrl)
		XCTAssertFalse("google.com".isValidHttpsUrl)
	}
	
	func testIsValidHttpUrl() {
		XCTAssertFalse("hello world!".isValidHttpUrl)
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
		XCTAssertNil("".lastCharacter)
	}
	
	func testLatinize() {
		var str = "Hëllô Teśt"
		str.latinize()
		XCTAssertEqual(str, "Hello Test")
	}
	
	func testLatinized() {
		XCTAssertEqual("Hëllô Teśt".latinized, "Hello Test")
	}
	
	func testLength() {
		XCTAssertEqual("Hello world!".length, 12)
	}
	
	func testLines() {
		XCTAssertEqual("Hello\ntest".lines, ["Hello", "test"])
	}
	
	func testMostCommonCharacter() {
		let mostCommonCharacter = "This is a test, since e is appearing every where e should be the common character".mostCommonCharacter
		XCTAssertEqual(mostCommonCharacter, "e")
	}
	
	func testRandom() {
		let str1 = String.random(ofLength: 10)
		XCTAssertEqual(str1.length, 10)
		
		let str2 = String.random(ofLength: 10)
		XCTAssertEqual(str2.length, 10)
		
		XCTAssertNotEqual(str1, str2)
		
		XCTAssertEqual(String.random(ofLength: 0), "")
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
		XCTAssertNil("12345678".slicing(at: 50))
		XCTAssertEqual("12345678".slicing(from: 2, length: 0)!, "")
		XCTAssertNil("12345678".slicing(from: 12, length: 0))
		XCTAssertEqual("12345678".slicing(from: 2, length: 100), "345678")
		XCTAssertEqual("12345678".slicing(from: 2, to: 5), "345")
		XCTAssertNil("12345678".slicing(from: 2, to: 1))
		XCTAssertEqual("12345678".slicing(at: 2)!, "345678")
		
		var str = "12345678"
		str.slice(from: 2, length: 3)
		XCTAssertEqual(str, "345")
		
		str = "12345678"
		str.slice(from: 2, length: 0)
		print(str)
		XCTAssertEqual(str, "")
		
		str = "12345678"
		str.slice(from: 12, length: 0)
		XCTAssertEqual(str, "12345678")
		
		str = "12345678"
		str.slice(from: 2, length: 100)
		XCTAssertEqual(str, "345678")
		
		str = "12345678"
		str.slice(from: 2, to: 5)
		XCTAssertEqual(str, "345")
		
		str = "12345678"
		str.slice(from: 2, to: 1)
		XCTAssertEqual(str, "12345678")
		
		str = "12345678"
		str.slice(at: 2)
		XCTAssertEqual(str, "345678")
	}
	
	func testSplit() {
		XCTAssertEqual("Hello Tests".splitted(by: " "), ["Hello", "Tests"])
	}
	
	func testStart() {
		XCTAssert("Hello Test".start(with: "hello", caseSensitive: false))
		XCTAssert("Hello Tests".start(with: "He"))
	}
	
	func testDateWithFormat() {
		let dateString = "2012-12-08 17:00:00.0"
		let date = dateString.date(withFormat: "yyyy-dd-MM HH:mm:ss.S")
		XCTAssertNotNil(date)
		XCTAssertNil(dateString.date(withFormat: "hello world!"))
	}
	
	func testOperators() {
		let sa = "sa"
		
		XCTAssertEqual(sa * 5, "sasasasasa")
		XCTAssertEqual(5 * sa, "sasasasasa")
		
		XCTAssertEqual(sa * 0, "")
		XCTAssertEqual(0 * sa, "")
		
		XCTAssertEqual(sa * -5, "")
		XCTAssertEqual(-5 * sa, "")
	}
	
	func testToBool() {
		XCTAssertNotNil("1".bool)
		XCTAssert("1".bool!)
		
		XCTAssertNotNil("false".bool)
		XCTAssertFalse("false".bool!)
		XCTAssertNil("8s".bool)
	}
	
	func testDate() {
		let dateFromStr = "2015-06-01".date
		XCTAssertNotNil(dateFromStr)
		XCTAssertEqual(dateFromStr!.year, 2015)
		XCTAssertEqual(dateFromStr!.month, 6)
		XCTAssertEqual(dateFromStr!.day, 1)
	}
	
	func testDateTime() {
		let dateFromStr = "2015-06-01 14:23:09".dateTime
		XCTAssertNotNil(dateFromStr)
		XCTAssertEqual(dateFromStr!.year, 2015)
		XCTAssertEqual(dateFromStr!.month, 6)
		XCTAssertEqual(dateFromStr!.day, 1)
		XCTAssertEqual(dateFromStr!.hour, 14)
		XCTAssertEqual(dateFromStr!.minute, 23)
		XCTAssertEqual(dateFromStr!.second, 9)
	}
	
	func testDouble() {
		XCTAssertNotNil("8".double)
		XCTAssertEqual("8".double!, 8)
		
		XCTAssertNotNil("8.23".double)
		XCTAssertEqual("8.23".double!, 8.23)
		
		XCTAssertNil("8s".double)
	}
	
	func testFloat() {
		XCTAssertNotNil("8".float)
		XCTAssertEqual("8".float!, 8)
		
		XCTAssertNotNil("8.23".float)
		XCTAssertEqual("8.23".float!, Float(8.23))
		
		XCTAssertNil("8s".float)
	}
	
	func testFloat32() {
		XCTAssertNotNil("8".float32)
		XCTAssertEqual("8".float32!, 8)
		
		XCTAssertNotNil("8.23".float32)
		XCTAssertEqual("8.23".float32!, Float32(8.23))
		
		XCTAssertNil("8s".float32)
	}
	
	func testFloat64() {
		XCTAssertNotNil("8".float64)
		XCTAssertEqual("8".float64!, 8)
		
		XCTAssertNotNil("8.23".float64)
		XCTAssertEqual("8.23".float64!, Float64(8.23))
		
		XCTAssertNil("8s".float64)
	}
	
	func testInt() {
		XCTAssertNotNil("8".int)
		XCTAssertEqual("8".int!, 8)
		
		XCTAssertNil("8s".int)
	}
	
	func testInt16() {
		XCTAssertNotNil("8".int16)
		XCTAssertEqual("8".int16!, 8)
		
		XCTAssertNil("8s".int16)
	}
	
	func testInt32() {
		XCTAssertNotNil("8".int32)
		XCTAssertEqual("8".int32!, 8)
		
		XCTAssertNil("8s".int32)
	}
	
	func testInt64() {
		XCTAssertNotNil("8".int64)
		XCTAssertEqual("8".int64!, 8)
		
		XCTAssertNil("8s".int64)
	}
	
	func testInt8() {
		XCTAssertNotNil("8".int8)
		XCTAssertEqual("8".int8!, 8)
		
		XCTAssertNil("8s".int8)
	}
	
	func testUrl() {
		XCTAssertNil("hello world".url)
		
		let google = "https://www.google.com"
		XCTAssertEqual(google.url, URL(string: google)!)
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
		
		str = "This is a very long sentence"
		str.truncate(toLength: 14, trailing: nil)
		XCTAssertEqual(str, "This is a very")
		
		str = "This is a short sentence"
		str.truncate(toLength: 100)
		XCTAssertEqual(str, "This is a short sentence")
		
		str.truncate(toLength: -1)
		XCTAssertEqual(str, "This is a short sentence")
	}
	
	func testTruncated() {
		XCTAssertEqual("This is a very long sentence".truncated(toLength: 14), "This is a very...")
		
		XCTAssertEqual("This is a very long sentence".truncated(toLength: 14, trailing: nil), "This is a very")
		XCTAssertEqual("This is a short sentence".truncated(toLength: 100), "This is a short sentence")
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
		XCTAssertEqual("%%".urlDecoded, "%%")
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
	
	func testSubscript() {
		let str = "Hello world!"
		XCTAssertEqual(str[1], "e")
		XCTAssertNil(str[18])
		
		XCTAssertEqual(str[1..<5], "ello")
		XCTAssertNil(str[10..<18])
		XCTAssertNil(""[1..<2])
		
		XCTAssertEqual(str[0...4], "Hello")
		XCTAssertNil(str[10...18])
		XCTAssertNil(""[1...2])
	}
	
	func testCopyToPasteboard() {
		let str = "Hello World!"
		#if os(iOS)
			str.copyToPasteboard()
			let strFromPasteboard = UIPasteboard.general.string
			XCTAssertEqual(strFromPasteboard, str)
			
		#elseif os(macOS)
			str.copyToPasteboard()
			let strFromPasteboard = NSPasteboard.general().string(forType: NSPasteboardTypeString)
			XCTAssertEqual(strFromPasteboard, str)
		#endif
	}
	
	func testInitRandomOfLength() {
		let str1 = String(randomOfLength: 10)
		XCTAssertEqual(str1.length, 10)
		
		let str2 = String(randomOfLength: 10)
		XCTAssertEqual(str2.length, 10)
		
		XCTAssertNotEqual(str1, str2)
		
		XCTAssertEqual(String(randomOfLength: 0), "")
		
	}
	
	func testInitFromBase64() {
		XCTAssertNotNil(String(base64: "SGVsbG8gV29ybGQh"))
		XCTAssertEqual(String(base64: "SGVsbG8gV29ybGQh")!, "Hello World!")
		XCTAssertNil(String(base64: "hello"))
	}
	
	func testNSString() {
		XCTAssertEqual("Hello".nsString, NSString(string: "Hello"))
	}
	
	func testLastPathComponent() {
		let string = "hello"
		let nsString = NSString(string: "hello")
		XCTAssertEqual(string.lastPathComponent, nsString.lastPathComponent)
		
	}
	
	func testLastPathExtension() {
		let string = "hello"
		let nsString = NSString(string: "hello")
		XCTAssertEqual(string.pathExtension, nsString.pathExtension)
	}
	
	func testLastDeletingLastPathComponent() {
		let string = "hello"
		let nsString = NSString(string: "hello")
		XCTAssertEqual(string.deletingLastPathComponent, nsString.deletingLastPathComponent)
	}
	
	func testLastDeletingPathExtension() {
		let string = "hello"
		let nsString = NSString(string: "hello")
		XCTAssertEqual(string.deletingPathExtension, nsString.deletingPathExtension)
	}
	
	func testLastPathComponents() {
		let string = "hello"
		let nsString = NSString(string: "hello")
		XCTAssertEqual(string.pathComponents, nsString.pathComponents)
	}
	
	func testAppendingPathComponent() {
		let string = "hello".appendingPathComponent("world")
		let nsString = NSString(string: "hello").appendingPathComponent("world")
		XCTAssertEqual(string, nsString)
	}
	
	func testAppendingPathExtension() {
		let string = "hello".appendingPathExtension("world")
		let nsString = NSString(string: "hello").appendingPathExtension("world")
		XCTAssertEqual(string, nsString)
	}
	
	#if !os(tvOS) && !os(watchOS)
	func testBold() {
		let boldString = "hello".bold
		let attrs = boldString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, boldString.length))
		XCTAssertNotNil(attrs[NSFontAttributeName])
		
		#if os(macOS)
			XCTAssertEqual(attrs[NSFontAttributeName] as! NSFont, NSFont.boldSystemFont(ofSize: NSFont.systemFontSize()))
		#elseif os(iOS)
			XCTAssertEqual(attrs[NSFontAttributeName] as! UIFont, UIFont.boldSystemFont(ofSize: UIFont.systemFontSize))
		#endif
	}
	#endif
	
	func testUnderline() {
		let underlinedString = "hello".underline
		let attrs = underlinedString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, underlinedString.length))
		XCTAssertNotNil(attrs[NSUnderlineStyleAttributeName])
		XCTAssertEqual(attrs[NSUnderlineStyleAttributeName] as! Int, NSUnderlineStyle.styleSingle.rawValue)
	}
	
	func testStrikethrough() {
		let strikedthroughString = "hello".strikethrough
		let attrs = strikedthroughString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, strikedthroughString.length))
		XCTAssertNotNil(attrs[NSStrikethroughStyleAttributeName])
		XCTAssertEqual(attrs[NSStrikethroughStyleAttributeName] as! NSNumber, NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int))
	}
	
	#if os(iOS)
	func testItalic() {
		let italicString = "hello".italic
		let attrs = italicString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, italicString.length))
		XCTAssertNotNil(attrs[NSFontAttributeName])
		XCTAssertEqual(attrs[NSFontAttributeName] as! UIFont, UIFont.italicSystemFont(ofSize: UIFont.systemFontSize))
	}
	#endif
	
	func testColored() {
		let coloredString = "hello".colored(with: .orange)
		let attrs = coloredString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, coloredString.length))
		XCTAssertNotNil(attrs[NSForegroundColorAttributeName])
		
		#if os(macOS)
			XCTAssertEqual(attrs[NSForegroundColorAttributeName] as! NSColor, NSColor.orange)
		#else
			XCTAssertEqual(attrs[NSForegroundColorAttributeName] as! UIColor, UIColor.orange)
		#endif
	}
}
