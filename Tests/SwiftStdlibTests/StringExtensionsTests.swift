//
//  StringExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

// swiftlint:disable:next type_body_length
final class StringExtensionsTests: XCTestCase {

    var helloWorld = "Hello World!"

    override func setUp() {
        super.setUp()
        NSTimeZone.default = NSTimeZone.system
    }

    func testBase64Decoded() {
        XCTAssertEqual("SGVsbG8gV29ybGQh".base64Decoded, helloWorld)
        XCTAssertNil(helloWorld.base64Decoded)
    }

    func testBase64Encoded() {
        XCTAssertEqual(helloWorld.base64Encoded, "SGVsbG8gV29ybGQh")
    }

    func testCharactersArray() {
        let str = "Swift"
        let chars = [Character("S"), Character("w"), Character("i"), Character("f"), Character("t")]
        XCTAssertEqual(str.charactersArray, chars)
    }

    func testCamelCased() {
        XCTAssertEqual("Hello test".camelCased, "helloTest")
        XCTAssertEqual("Hellotest".camelCased, "hellotest")
    }

    func testContainEmoji() {
        XCTAssert("Hello 😂".containEmoji)
        XCTAssertFalse("Hello ;)".containEmoji)
    }

    func testFirstCharacter() {
        XCTAssertNil("".firstCharacterAsString)
        XCTAssertNotNil("Hello".firstCharacterAsString)
        XCTAssertEqual("Hello".firstCharacterAsString, "H")
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

    func testIsPalindrome() {
        XCTAssert("abcdcba".isPalindrome)
        XCTAssert("Mom".isPalindrome)
        XCTAssert("A man a plan a canal, Panama!".isPalindrome)
        XCTAssertFalse("Mama".isPalindrome)
        XCTAssertFalse("".isPalindrome)
    }

    func testisValidEmail() {
        // https://blogs.msdn.microsoft.com/testing123/2009/02/06/email-address-test-cases/

        XCTAssert("email@domain.com".isValidEmail)
        XCTAssert("firstname.lastname@domain.com".isValidEmail)
        XCTAssert("email@subdomain.domain.com".isValidEmail)
        XCTAssert("firstname+lastname@domain.com".isValidEmail)
        XCTAssert("email@123.123.123.123".isValidEmail)
        XCTAssert("email@[123.123.123.123]".isValidEmail)
        XCTAssert("\"email\"@domain.com".isValidEmail)
        XCTAssert("1234567890@domain.com".isValidEmail)
        XCTAssert("email@domain-one.com".isValidEmail)
        XCTAssert("_______@domain.com".isValidEmail)
        XCTAssert("email@domain.name".isValidEmail)
        XCTAssert("email@domain.co.jp".isValidEmail)
        XCTAssert("firstname-lastname@domain.com".isValidEmail)

        XCTAssertFalse("".isValidEmail)
        XCTAssertFalse("plainaddress".isValidEmail)
        XCTAssertFalse("#@%^%#$@#$@#.com".isValidEmail)
        XCTAssertFalse("@domain.com".isValidEmail)
        XCTAssertFalse("Joe Smith <email@domain.com>".isValidEmail)
        XCTAssertFalse("email.domain.com".isValidEmail)
        XCTAssertFalse("email@domain@domain.com".isValidEmail)
        XCTAssertFalse(".email@domain.com".isValidEmail)
        XCTAssertFalse("email.@domain.com".isValidEmail)
        XCTAssertFalse("email..email@domain.com".isValidEmail)
        XCTAssertFalse("email@domain.com (Joe Smith)".isValidEmail)
        XCTAssertFalse("email@domain".isValidEmail)
        XCTAssertFalse("email@-domain.com".isValidEmail)
        XCTAssertFalse(" email@domain.com".isValidEmail)
        XCTAssertFalse("email@domain.com ".isValidEmail)
        XCTAssertFalse("\nemail@domain.com".isValidEmail)
        XCTAssertFalse("nemail@domain.com   \n\n".isValidEmail)
    }

    func testIsValidUrl() {
        XCTAssert("https://google.com".isValidUrl)
        XCTAssert("http://google.com".isValidUrl)
        XCTAssert("ftp://google.com".isValidUrl)
    }

    func testIsValidSchemedUrl() {
        XCTAssertFalse("Hello world!".isValidSchemedUrl)
        XCTAssert("https://google.com".isValidSchemedUrl)
        XCTAssert("ftp://google.com".isValidSchemedUrl)
        XCTAssertFalse("google.com".isValidSchemedUrl)
    }

    func testIsValidHttpsUrl() {
        XCTAssertFalse("Hello world!".isValidHttpsUrl)
        XCTAssert("https://google.com".isValidHttpsUrl)
        XCTAssertFalse("http://google.com".isValidHttpsUrl)
        XCTAssertFalse("google.com".isValidHttpsUrl)
    }

    func testIsValidHttpUrl() {
        XCTAssertFalse("Hello world!".isValidHttpUrl)
        XCTAssert("http://google.com".isValidHttpUrl)
        XCTAssertFalse("google.com".isValidHttpUrl)
    }

    func testIsValidFileURL() {
        XCTAssertFalse("Hello world!".isValidFileUrl)
        XCTAssert("file://var/folder/file.txt".isValidFileUrl)
        XCTAssertFalse("google.com".isValidFileUrl)
    }

    func testIsNumeric() {
        XCTAssert("123".isNumeric)
        XCTAssert("123.4".isNumeric)
        XCTAssert("1.25e2".isNumeric)
        XCTAssert("1.25e-2".isNumeric)
        XCTAssert("000123.456".isNumeric)
        XCTAssertFalse("123abc".isNumeric)
        XCTAssertFalse("abc".isNumeric)
        XCTAssertFalse("123.@.".isNumeric)
    }

    func testIsDigits() {
        XCTAssert("123".isDigits)
        XCTAssert("987654321".isDigits)
        XCTAssertFalse("123.4".isDigits)
        XCTAssertFalse("1.25e2".isDigits)
        XCTAssertFalse("123abc".isDigits)
    }

    func testLastCharacter() {
        XCTAssertNotNil("Hello".lastCharacterAsString)
        XCTAssertEqual("Hello".lastCharacterAsString, "o")
        XCTAssertNil("".lastCharacterAsString)
    }

    func testLatinized() {
        XCTAssertEqual("Hëllô Teśt".latinized, "Hello Test")
    }

    func testBool() {
        XCTAssertNotNil("1".bool)
        XCTAssert("1".bool!)

        XCTAssertNotNil("false".bool)
        XCTAssertFalse("false".bool!)
        XCTAssertNil("8s".bool)
    }

    func testDate() {
        let dateFromStr = "2015-06-01".date
        XCTAssertNotNil(dateFromStr)
        XCTAssertEqual(dateFromStr?.year, 2015)
        XCTAssertEqual(dateFromStr?.month, 6)
        XCTAssertEqual(dateFromStr?.day, 1)
    }

    func testDateTime() {
        let dateFromStr = "2015-06-01 14:23:09".dateTime
        XCTAssertNotNil(dateFromStr)
        XCTAssertEqual(dateFromStr?.year, 2015)
        XCTAssertEqual(dateFromStr?.month, 6)
        XCTAssertEqual(dateFromStr?.day, 1)
        XCTAssertEqual(dateFromStr?.hour, 14)
        XCTAssertEqual(dateFromStr?.minute, 23)
        XCTAssertEqual(dateFromStr?.second, 9)
    }

    func testInt() {
        XCTAssertNotNil("8".int)
        XCTAssertEqual("8".int, 8)

        XCTAssertNil("8s".int)
    }

    func testLoremIpsum() {
        // https://www.lipsum.com/
        let completeLoremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """

        XCTAssertEqual(String.loremIpsum(), completeLoremIpsum)
        XCTAssertEqual(String.loremIpsum(ofLength: 0), "")
        XCTAssertEqual(String.loremIpsum(ofLength: 26), "Lorem ipsum dolor sit amet")
    }

    func testUrl() {
        XCTAssertNil("hello world".url)

        let google = "https://www.google.com"
        XCTAssertEqual(google.url, URL(string: google))
    }

    func testTrimmed() {
        XCTAssertEqual("\n Hello \n ".trimmed, "Hello")
    }

    func testUrlDecoded() {
        XCTAssertEqual("it's%20easy%20to%20encode%20strings".urlDecoded, "it's easy to encode strings")
        XCTAssertEqual("%%".urlDecoded, "%%")
    }

    func testUrlEncoded() {
        XCTAssertEqual("it's easy to encode strings".urlEncoded, "it's%20easy%20to%20encode%20strings")
    }

    func testWithoutSpacesAndNewLines() {
        XCTAssertEqual("Hello \n Test".withoutSpacesAndNewLines, "HelloTest")
    }

    func testIsWhiteSpaces() {
        var str = "test string"
        XCTAssertEqual(str.isWhitespace, false)

        str = "     "
        XCTAssertEqual(str.isWhitespace, true)

        str = "   \n \n  "
        XCTAssertEqual(str.isWhitespace, true)
    }

    func testFloat() {
        XCTAssertNotNil("8".float())
        XCTAssertEqual("8".float(), 8)

        XCTAssertNotNil("8.23".float(locale: Locale(identifier: "en_US_POSIX")))
        XCTAssertEqual("8.23".float(locale: Locale(identifier: "en_US_POSIX")), Float(8.23))

        #if os(Linux)
        XCTAssertEqual("8s".float(), 8)
        #else
        XCTAssertNil("8s".float())
        #endif
    }

    func testDouble() {
        XCTAssertNotNil("8".double())
        XCTAssertEqual("8".double(), 8)

        XCTAssertNotNil("8.23".double(locale: Locale(identifier: "en_US_POSIX")))
        XCTAssertEqual("8.23".double(locale: Locale(identifier: "en_US_POSIX")), 8.23)

        #if os(Linux)
        XCTAssertEqual("8s".double(), 8)
        #else
        XCTAssertNil("8s".double())
        #endif
    }

    func testCgFloat() {
        #if !os(Linux)
        XCTAssertNotNil("8".cgFloat())
        XCTAssertEqual("8".cgFloat(), 8)

        XCTAssertNotNil("8.23".cgFloat(locale: Locale(identifier: "en_US_POSIX")))
        XCTAssertEqual("8.23".cgFloat(locale: Locale(identifier: "en_US_POSIX")), CGFloat(8.23))

        XCTAssertNil("8s".cgFloat())
        #endif
    }

    func testLines() {
        #if !os(Linux)
        XCTAssertEqual("Hello\ntest".lines(), ["Hello", "test"])
        #endif
    }

    func testLocalized() {
        XCTAssertEqual(helloWorld.localized(), NSLocalizedString(helloWorld, comment: ""))
        XCTAssertEqual(helloWorld.localized(comment: "comment"), NSLocalizedString(helloWorld, comment: "comment"))
    }

    func testMostCommonCharacter() {
        let mostCommonCharacter = "This is a test, since e is appearing every where e should be the common character".mostCommonCharacter
        XCTAssertEqual(mostCommonCharacter(), "e")
        XCTAssertNil("".mostCommonCharacter())
    }

    func testUnicodeArray() {
        XCTAssertEqual("Hello".unicodeArray(), [72, 101, 108, 108, 111])
    }

    func testWords() {
        XCTAssertEqual("Swift is amazing".words(), ["Swift", "is", "amazing"])
    }

    func testWordsCount() {
        XCTAssertEqual("Swift is amazing".wordCount(), 3)
    }

    func testToSlug() {
        let str = "  A nice & hög _ Str    "
        XCTAssertEqual(str.toSlug(), "a-nice-&-hog-str")
        XCTAssertEqual("Swift is amazing".toSlug(), "swift-is-amazing")
    }

    func testSubscript() {
        let str = "Hello world!"
        XCTAssertEqual(str[safe: 1], "e")
        XCTAssertNil(str[safe: 18])

        XCTAssertEqual(str[safe: 1..<5], "ello")
        XCTAssertNil(str[safe: 10..<18])
        XCTAssertNil(""[safe: 1..<2])

        XCTAssertEqual(str[safe: 0...4], "Hello")
        XCTAssertNil(str[safe: 10...18])
        XCTAssertNil(""[safe: 1...2])
    }

    func testCopyToPasteboard() {
        let str = "Hello world!"
        #if os(iOS)
        str.copyToPasteboard()
        let strFromPasteboard = UIPasteboard.general.string
        XCTAssertEqual(strFromPasteboard, str)

        #elseif os(macOS)
        str.copyToPasteboard()
        let strFromPasteboard = NSPasteboard.general.string(forType: .string)
        XCTAssertEqual(strFromPasteboard, str)
        #endif
    }

    func testCamelize() {
        var str = "Hello test"
        str.camelize()
        XCTAssertEqual(str, "helloTest")

        str = "helloWorld"
        str.camelize()
        XCTAssertEqual(str, "helloworld")
    }

    func testFirstCharacterUppercased() {
        var str = "hello test"
        str.firstCharacterUppercased()
        XCTAssertEqual(str, "Hello test")

        str = "helloworld"
        str.firstCharacterUppercased()
        XCTAssertEqual(str, "Helloworld")

        str = ""
        str.firstCharacterUppercased()
        XCTAssertEqual(str, "")

    }

    func testHasUniqueCharacters() {
        XCTAssert("swift".hasUniqueCharacters())
        XCTAssertFalse("language".hasUniqueCharacters())
        XCTAssertFalse("".hasUniqueCharacters())
    }

    func testContain() {
        XCTAssert("Hello Tests".contains("Hello", caseSensitive: true))
        XCTAssert("Hello Tests".contains("hello", caseSensitive: false))
    }

    func testCount() {
        XCTAssertEqual("Hello This Tests".count(of: "T"), 2)
        XCTAssertEqual("Hello This Tests".count(of: "t"), 1)
        XCTAssertEqual("Hello This Tests".count(of: "T", caseSensitive: false), 3)
        XCTAssertEqual("Hello This Tests".count(of: "t", caseSensitive: false), 3)
    }

    func testEnd() {
        XCTAssert("Hello Test".ends(with: "test", caseSensitive: false))
        XCTAssert("Hello Tests".ends(with: "sts"))
    }

    func testLatinize() {
        var str = "Hëllô Teśt"
        str.latinize()
        XCTAssertEqual(str, "Hello Test")
    }

    func testRandom() {
        let str1 = String.random(ofLength: 10)
        XCTAssertEqual(str1.count, 10)

        let str2 = String.random(ofLength: 10)
        XCTAssertEqual(str2.count, 10)

        XCTAssertNotEqual(str1, str2)

        XCTAssertEqual(String.random(ofLength: 0), "")
    }

    func testReverse() {
        var str = "Hello"
        str.reverse()
        XCTAssertEqual(str, "olleH")
    }

    func testSlice() {
        XCTAssertEqual("12345678".slicing(from: 2, length: 3), "345")
        XCTAssertEqual("12345678".slicing(from: 2, length: 0), "")
        XCTAssertNil("12345678".slicing(from: 12, length: 0))
        XCTAssertEqual("12345678".slicing(from: 2, length: 100), "345678")

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

        str = "12345678"
        str.slice(at: 20)
        XCTAssertEqual(str, "12345678")
    }

    func testStart() {
        XCTAssert("Hello Test".starts(with: "hello", caseSensitive: false))
        XCTAssert("Hello Tests".starts(with: "He"))
    }

    func testDateWithFormat() {
        let dateString = "2012-12-08 17:00:00.0"
        let date = dateString.date(withFormat: "yyyy-dd-MM HH:mm:ss.S")
        XCTAssertNotNil(date)
        XCTAssertNil(dateString.date(withFormat: "Hello world!"))
    }

    func testTrim() {
        var str = "\n Hello \n "
        str.trim()
        XCTAssertEqual(str, "Hello")
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

    func testUrlDecode() {
        var url = "it's%20easy%20to%20encode%20strings"
        url.urlDecode()
        XCTAssertEqual(url, "it's easy to encode strings")
    }

    func testUrlEncode() {
        var url = "it's easy to encode strings"
        url.urlEncode()
        XCTAssertEqual(url, "it's%20easy%20to%20encode%20strings")
    }

    func testMatches() {
        XCTAssertTrue("123".matches(pattern: "\\d{3}"))
        XCTAssertFalse("dasda".matches(pattern: "\\d{3}"))
        XCTAssertFalse("notanemail.com".matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"))
        XCTAssertTrue("email@mail.com".matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"))
    }

    func testPadStart() {
        var str: String = "str"
        str.padStart(10)
        XCTAssertEqual(str, "       str")

        str = "str"
        str.padStart(10, with: "br")
        XCTAssertEqual(str, "brbrbrbstr")

        str = "str"
        str.padStart(5, with: "brazil")
        XCTAssertEqual(str, "brstr")

        str = "str"
        str.padStart(6, with: "a")
        XCTAssertEqual(str, "aaastr")

        str = "str"
        str.padStart(6, with: "abc")
        XCTAssertEqual(str, "abcstr")

        str = "str"
        str.padStart(2)
        XCTAssertEqual(str, "str")
    }

    func testPaddingStart() {
        XCTAssertEqual("str".paddingStart(10), "       str")
        XCTAssertEqual("str".paddingStart(10, with: "br"), "brbrbrbstr")
        XCTAssertEqual("str".paddingStart(5, with: "brazil"), "brstr")
        XCTAssertEqual("str".paddingStart(6, with: "a"), "aaastr")
        XCTAssertEqual("str".paddingStart(6, with: "abc"), "abcstr")
        XCTAssertEqual("str".paddingStart(2), "str")
    }

    func testPadEnd() {
        var str: String = "str"
        str.padEnd(10)
        XCTAssertEqual(str, "str       ")

        str = "str"
        str.padEnd(10, with: "br")
        XCTAssertEqual(str, "strbrbrbrb")

        str = "str"
        str.padEnd(5, with: "brazil")
        XCTAssertEqual(str, "strbr")

        str = "str"
        str.padEnd(6, with: "a")
        XCTAssertEqual(str, "straaa")

        str = "str"
        str.padEnd(6, with: "abc")
        XCTAssertEqual(str, "strabc")

        str = "str"
        str.padEnd(2)
        XCTAssertEqual(str, "str")
    }

    func testPaddingEnd() {
        XCTAssertEqual("str".paddingEnd(10), "str       ")
        XCTAssertEqual("str".paddingEnd(10, with: "br"), "strbrbrbrb")
        XCTAssertEqual("str".paddingEnd(5, with: "brazil"), "strbr")
        XCTAssertEqual("str".paddingEnd(6, with: "a"), "straaa")
        XCTAssertEqual("str".paddingEnd(6, with: "abc"), "strabc")
        XCTAssertEqual("str".paddingEnd(2), "str")
    }

    func testIsSpelledCorrectly() {
        #if os(iOS) || os(tvOS)
        let strCorrect = "Hello, World!"

        XCTAssertTrue(strCorrect.isSpelledCorrectly)

        let strNonCorrect = "Helol, Wrold!"
        XCTAssertFalse(strNonCorrect.isSpelledCorrectly)
        #endif
    }

    func testRemovingPrefix() {
        let inputStr = "Hello, World!"
        XCTAssertEqual(inputStr.removingPrefix("Hello, "), "World!")
    }

    func testRemovingSuffix() {
        let inputStr = "Hello, World!"
        XCTAssertEqual(inputStr.removingSuffix(", World!"), "Hello")
    }

    func testInitFromBase64() {
        XCTAssertNotNil(String(base64: "SGVsbG8gV29ybGQh"))
        XCTAssertEqual(String(base64: "SGVsbG8gV29ybGQh"), "Hello World!")
        XCTAssertNil(String(base64: "hello"))
    }

    func testInitRandomOfLength() {
        let str1 = String(randomOfLength: 10)
        XCTAssertEqual(str1.count, 10)

        let str2 = String(randomOfLength: 10)
        XCTAssertEqual(str2.count, 10)

        XCTAssertNotEqual(str1, str2)

        XCTAssertEqual(String(randomOfLength: 0), "")
    }

    func testBold() {
        #if canImport(Foundation) && os(macOS)
        let boldString = "hello".bold
        // swiftlint:disable:next legacy_constructor
        let attrs = boldString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, boldString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.font])

        #if os(macOS)
        guard let font = attrs[.font] as? NSFont else {
            XCTFail("Unable to find font in testBold")
            return
        }
        XCTAssertEqual(font, NSFont.boldSystemFont(ofSize: NSFont.systemFontSize))
        #elseif os(iOS)
        guard let font = attrs[NSAttributedString.Key.font] as? UIFont else {
            XCTFail("Unable to find font in testBold")
            return
        }
        XCTAssertEqual(font, UIFont.boldSystemFont(ofSize: UIFont.systemFontSize))
        #endif
        #endif
    }

    func testUnderline() {
        #if !os(Linux)
        let underlinedString = "hello".underline
        // swiftlint:disable:next legacy_constructor
        let attrs = underlinedString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, underlinedString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.underlineStyle])
        guard let style = attrs[NSAttributedString.Key.underlineStyle] as? Int else {
            XCTFail("Unable to find style in testUnderline")
            return
        }
        XCTAssertEqual(style, NSUnderlineStyle.single.rawValue)
        #endif
    }

    func testStrikethrough() {
        #if !os(Linux)
        let strikedthroughString = "hello".strikethrough
        // swiftlint:disable:next legacy_constructor
        let attrs = strikedthroughString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, strikedthroughString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.strikethroughStyle])
        guard let style = attrs[NSAttributedString.Key.strikethroughStyle] as? NSNumber else {
            XCTFail("Unable to find style in testStrikethrough")
            return
        }
        XCTAssertEqual(style, NSNumber(value: NSUnderlineStyle.single.rawValue as Int))
        #endif
    }

    func testItalic() {
        #if os(iOS)
        let italicString = "hello".italic
        // swiftlint:disable:next legacy_constructor
        let attrs = italicString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, italicString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.font])
        guard let font = attrs[NSAttributedString.Key.font] as? UIFont else {
            XCTFail("Unable to find font in testItalic")
            return
        }
        XCTAssertEqual(font, UIFont.italicSystemFont(ofSize: UIFont.systemFontSize))
        #endif
    }

    func testColored() {
        #if canImport(Cocoa)
        let coloredString = "hello".colored(with: .orange)
        // swiftlint:disable:next legacy_constructor
        let attrs = coloredString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, coloredString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.foregroundColor])

        guard let color = attrs[.foregroundColor] as? NSColor else {
            XCTFail("Unable to find color in testColored")
            return
        }
        XCTAssertEqual(color, NSColor.orange)
        #endif
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

    func testOperators() {
        let testString = "sa"

        XCTAssertEqual(testString * 5, "sasasasasa")
        XCTAssertEqual(5 * testString, "sasasasasa")

        XCTAssertEqual(testString * 0, "")
        XCTAssertEqual(0 * testString, "")

        XCTAssertEqual(testString * -5, "")
        XCTAssertEqual(-5 * testString, "")
    }

    func testIntSpellOut() {
        let num = 12.32
        XCTAssertNotNil(num.spelledOutString(locale: Locale(identifier: "en_US")))
        XCTAssertEqual(num.spelledOutString(locale: Locale(identifier: "en_US")), "twelve point three two")
    }

    @available(iOS 9.0, macOS 10.11, *)
    func testIntOrdinal() {
        let num = 12
        XCTAssertNotNil(num.ordinalString())
        XCTAssertEqual(num.ordinalString(), "12th")
    }

}
