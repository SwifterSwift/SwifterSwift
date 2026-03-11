// NSRegularExpressionExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

final class NSRegularExpressionExtensionsTests: XCTestCase {
    private let string = "bar foo bar foo bar"
    private let searchString = "bar"
    private let expectedMatches = 3
    private lazy var regularExpression =
        try! NSRegularExpression(pattern: searchString) // swiftlint:disable:this force_try

    func testEnumerateMatches() {
        var count = 0
        regularExpression.enumerateMatches(in: string,
                                           options: [],
                                           range: string.startIndex..<string.endIndex) { result, _, _ in
            XCTAssertEqual(
                String(self.string[Range(result!.range, in: self.string)!]),
                self.searchString)
            count += 1
        }
        XCTAssertEqual(count, expectedMatches)

        count = 0
        let max = 2 // must be less than expectedMatches
        regularExpression.enumerateMatches(in: string,
                                           options: [],
                                           range: string.startIndex..<string.endIndex) { result, _, stop in
            XCTAssertEqual(
                String(self.string[Range(result!.range, in: self.string)!]),
                self.searchString)
            count += 1
            stop = count >= max
        }
        XCTAssertEqual(count, max)
    }

    func testMatches() throws {
        let matches = regularExpression.matches(in: string,
                                                options: [],
                                                range: string.startIndex..<string.endIndex)
        XCTAssertEqual(matches.count, expectedMatches)
        for match in matches {
            XCTAssertEqual(try String(string[XCTUnwrap(Range(match.range, in: string))]), searchString)
        }
    }

    func testNumberOfMatches() {
        XCTAssertEqual(regularExpression.numberOfMatches(in: string,
                                                         options: [],
                                                         range: string.startIndex..<string.endIndex),
                       expectedMatches)
    }

    func testFirstMatch() throws {
        let firstMatch = regularExpression.firstMatch(in: string,
                                                      options: [],
                                                      range: string.startIndex..<string.endIndex)
        XCTAssertNotNil(firstMatch)
        XCTAssertEqual(firstMatch?.range.location, 0)
        XCTAssertEqual(try String(string[XCTUnwrap(try Range(XCTUnwrap(firstMatch?.range), in: string))]), searchString)
    }

    func testRangeOfFirstMatch() throws {
        let range = regularExpression.rangeOfFirstMatch(in: string,
                                                        options: [],
                                                        range: string.startIndex..<string.endIndex)
        XCTAssertNotNil(range)
        XCTAssertEqual(range?.lowerBound, string.startIndex)
        XCTAssertEqual(range?.upperBound, string.index(string.startIndex, offsetBy: searchString.count))
        XCTAssertEqual(try String(string[XCTUnwrap(range)]), searchString)

        let foo = "foo"
        XCTAssertNil(regularExpression.rangeOfFirstMatch(in: foo, options: [], range: foo.startIndex..<foo.endIndex))
    }

    func testStringByReplacingMatches() {
        let newString = regularExpression.stringByReplacingMatches(in: string,
                                                                   options: [],
                                                                   range: string.startIndex..<string.endIndex,
                                                                   withTemplate: "$0$0")
        XCTAssertEqual(newString, "barbar foo barbar foo barbar")
    }

    func testReplaceMatches() {
        var newString = string
        let matches = regularExpression.replaceMatches(in: &newString,
                                                       options: [],
                                                       range: string.startIndex..<string.endIndex,
                                                       withTemplate: "$0$0")
        XCTAssertEqual(newString, "barbar foo barbar foo barbar")
        XCTAssertEqual(matches, expectedMatches)
    }
}

#endif
