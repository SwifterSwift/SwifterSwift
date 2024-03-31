// StringProtocolExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

final class StringProtocolExtensionsTests: XCTestCase {
    func testCommonSuffix() {
        let string1 = "Hello world!"

        XCTAssert("".commonSuffix(with: "It's cold!").isEmpty)
        XCTAssert(string1.commonSuffix(with: "").isEmpty)

        XCTAssertEqual(string1.commonSuffix(with: "It's cold!"), "ld!")
        XCTAssertEqual(string1.commonSuffix(with: "ld!"), "ld!")
        XCTAssertEqual(string1.commonSuffix(with: "Not Common"), "")
        XCTAssertEqual(string1.commonSuffix(with: "It's colD!"), "!")
        XCTAssertEqual(string1.commonSuffix(with: "Hello world!"), "Hello world!")
        XCTAssertEqual(string1.commonSuffix(with: "It's colD!", options: .caseInsensitive), "ld!")
        XCTAssertEqual(string1.commonSuffix(with: "It's cold!", options: .literal), "ld!")
        XCTAssertEqual("Pelé".commonSuffix(with: "ele"), "")
        XCTAssertEqual("Pelé".commonSuffix(with: "ele", options: .diacriticInsensitive), "elé")

        XCTAssertEqual("huea\u{308}hue".commonSuffix(with: "hue\u{E4}hue"), "huea\u{308}hue")
        XCTAssertEqual("hue\u{308}hue".commonSuffix(with: "hue\u{E4}hue", options: .literal), "hue")
        XCTAssertEqual("hue\u{308}hue".commonSuffix(with: "hue\u{E4}hUe", options: [.caseInsensitive, .literal]), "hue")

        XCTAssertEqual(string1.commonSuffix(with: "你好世界"), "")
    }

    func testReplacingOccurrences() {
        XCTAssertEqual("", "".replacingOccurrences(ofPattern: "empty", withTemplate: "case"))

        let string = "hello"
        XCTAssertEqual("hello", string.replacingOccurrences(ofPattern: "not", withTemplate: "found"))
        XCTAssertEqual("hexo", string.replacingOccurrences(ofPattern: "l+", withTemplate: "x"))
        XCTAssertEqual("hellxo", string.replacingOccurrences(ofPattern: "(ll)", withTemplate: "$1x"))

        let options: String.CompareOptions = [.caseInsensitive]
        XCTAssertEqual("hexo", string.replacingOccurrences(ofPattern: "L+", withTemplate: "x", options: options))

        let range1 = string.startIndex..<string.index(string.startIndex, offsetBy: 3)
        XCTAssertEqual("hexlo", string.replacingOccurrences(ofPattern: "l", withTemplate: "x", range: range1))
    }
}
