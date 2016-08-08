//
//  StringExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift


class StringExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testLocale() {
        XCTAssert("Hello Tests".locale == Locale.current, "Couldn't get correct value for \(#function)")
    }
    
    func testCount() {
        XCTAssert("Hello Tests".count(of: "e") == 2, "Couldn't get correct value for \(#function)")
    }
    
    func testContain() {
        XCTAssert("Hello Tests".contains("Hello") == true, "Couldn't get correct value for \(#function)")
    }
    
    func testStarts() {
        XCTAssert("Hello Tests".starts(with: "He"), "Couldn't get correct value for \(#function)")
    }
    
    func testEnds() {
        XCTAssert("Hello Tests".ends(with: "sts"), "Couldn't get correct value for \(#function)")
    }
    
    func testEmpty() {
        let emptyStr = " \n"
        XCTAssert(emptyStr.empty == true && "Hello Tests".empty == false, "Couldn't get correct value for \(#function)")
    }
    
    func testSplit() {
        XCTAssert("Hello Tests".split(by: " ") == ["Hello", "Tests"], "Couldn't get correct value for \(#function)")
    }
    
    func testTrimmed() {
        XCTAssert("\n Hello \n ".trimmed == "Hello", "Couldn't get correct value for \(#function) function")
    }
    
    func testTrim() {
        var str = "\n Hello \n "
        str.trim()
        XCTAssert(str == "Hello", "Couldn't get correct value for \(#function) function")
    }
    
    func testFirstCharacter() {
        guard let firstCharacter = "Hello".firstCharacter else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        XCTAssert(firstCharacter == "H", "Couldn't get correct value for \(#function) function")
    }
    
    func testLastCharacter() {
        guard let lastCharacter = "Hello".lastCharacter else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        XCTAssert(lastCharacter == "o", "Couldn't get correct value for \(#function) function")
    }
    
    func testWithoutSpacesAndNewLines() {
        XCTAssert("Hello \n Test".withoutSpacesAndNewLines == "HelloTest", "Couldn't get correct value for \(#function) function")
    }
    
    func testMostCommonCharacter() {
        let mostCommonCharacter = "This is a test, since e is appearing every where e should be the common character".mostCommonCharacter
        XCTAssert(mostCommonCharacter == "e", "Couldn't get correct value for \(#function) function")
    }
    
    func testCamelCaseString() {
        XCTAssert("Hello test".camelCaseString == "helloTest", "Couldn't get correct value for \(#function) function")
    }
    
    func testCamelize() {
        var str = "Hello test"
        str.camelize()
        XCTAssert(str == "helloTest", "Couldn't get correct value for \(#function) function")
    }
    
    func testLines() {
        XCTAssert("Hello\ntest".lines() == ["Hello", "test"], "Couldn't get correct value for \(#function) function")
    }
    
    func testIsEmail() {
        XCTAssert("omaralbeik@gmail.com".isEmail == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("omaralbeik@gmailcom".isEmail == false, "Couldn't get correct value for \(#function) function")
        XCTAssert("omaralbeikgmail.com".isEmail == false, "Couldn't get correct value for \(#function) function")
    }
    
    func testIsHttpUrl() {
        XCTAssert("http://google.com".isHttpUrl == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("google.com".isHttpUrl == false, "Couldn't get correct value for \(#function) function")
    }
    
    func testIsHttpsUrl() {
        XCTAssert("https://google.com".isHttpsUrl == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("http://google.com".isHttpsUrl == false, "Couldn't get correct value for \(#function) function")
        XCTAssert("google.com".isHttpsUrl == false, "Couldn't get correct value for \(#function) function")
    }
    
    func testReversed() {
        XCTAssert("Hello".reversed == "olleH", "Couldn't get correct value for \(#function) function")
    }
    
    func testReverse() {
        var str = "Hello"
        str.reverse()
        XCTAssert(str == "olleH", "Couldn't get correct value for \(#function) function")
    }
    
    func testFirstIndex() {
        XCTAssert("Hello Test".firstIndex(of: "e") == 1, "Couldn't get correct value for \(#function) function")
    }
    
    func testReplace() {
        XCTAssert("Hello Test".replace(string: "e", with: "a") == "Hallo Tast", "Couldn't get correct value for \(#function) function")
    }
    
    func testHasNumbers() {
        XCTAssert("hsj 1 wq3".hasNumbers == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("123".hasNumbers == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("Hello test".hasNumbers == false, "Couldn't get correct value for \(#function) function")
    }
    
    func testHasLetters() {
        XCTAssert("hsj 1 wq3".hasLetters == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("123".hasLetters == false, "Couldn't get correct value for \(#function) function")
        XCTAssert("Hello test".hasLetters == true, "Couldn't get correct value for \(#function) function")
    }
    
    func testIsNumeric() {
        XCTAssert("123".isNumeric == true, "Couldn't get correct value for \(#function) function")
        XCTAssert("123abc".isNumeric == false, "Couldn't get correct value for \(#function) function")
        XCTAssert("abc".isNumeric == false, "Couldn't get correct value for \(#function) function")
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
    
    func testLatinized() {
        XCTAssert("Hëllô Teśt".latinized == "Hello Test", "Couldn't get correct value for \(#function) function")
    }
    
    func testLatinize() {
        var str = "Hëllô Teśt"
        str.latinize()
        XCTAssert(str == "Hello Test", "Couldn't get correct value for \(#function) function")
    }
    
    func testRandom() {
        XCTAssert(String.random(of: 10).characters.count == 10, "Couldn't get correct value for \(#function) function")
    }
    
    func testToInt() {
        guard let num = "8".toInt, num == 8 else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard "8s".toInt == nil else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
    }
    
    func testToFloat() {
        guard let num = "8".toFloat, num == 8 else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard let num2 = "8.23".toFloat, num2 == 8.23 else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard "8s".toFloat == nil else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
    }
    
    func testToDouble() {
        guard let num = "8".toDouble, num == 8 else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard let num2 = "8.23".toDouble, num2 == 8.23 else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard "8s".toDouble == nil else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
    }
    
    func testToBool() {
        guard let num = "1".toBool, num == true else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard let num2 = "false".toBool, num2 == false else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
        guard "8s".toBool == nil else {
            XCTAssert(false, "Couldn't get correct value for \(#function) function")
            return
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
