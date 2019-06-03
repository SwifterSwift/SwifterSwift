//
//  OptionalExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

private enum OptionalTestError: Error {
    case optionalIsNil
}

final class OptionalExtensionsTests: XCTestCase {

    func testUnwrappedOrDefault() {
        var str: String?
        XCTAssertEqual(str.unwrapped(or: "swift"), "swift")

        str = "swifterswift"
        XCTAssertEqual(str.unwrapped(or: "swift"), "swifterswift")
    }

    func testUnwrappedOrError() {
        let null: String? = nil
        try XCTAssertThrowsError(null.unwrapped(or: OptionalTestError.optionalIsNil))

        let some: String? = "I exist"
        try XCTAssertNoThrow(some.unwrapped(or: OptionalTestError.optionalIsNil))
    }

    func testRunBlock() {
        var str: String?
        var didRun = false
        str.run { _ in
            didRun = true
        }
        XCTAssertFalse(didRun)
        str = "swift"
        str.run { item in
            didRun = true
            XCTAssert(didRun)
            XCTAssertEqual(item, "swift")
        }
    }

    func testOptionalAssignment() {
        let parameter1: String? = nil
        let parameter2: String? = "foo"

        let key1: String = "key1"
        let key2: String = "key2"

        var parameters = [String: String]()

        parameters[key1] ??= parameter1
        parameters[key2] ??= parameter2

        XCTAssert(parameters[key1] == nil)
        XCTAssertFalse(parameters[key1] != parameter1)
        XCTAssert(parameters[key2] == parameter2)
    }

    func testConditionalAssignment() {
        var text1: String?
        text1 ?= "newText1"
        XCTAssertEqual(text1, "newText1")

        var text2: String? = "text2"
        text2 ?= "newText2"
        XCTAssertEqual(text2, "text2")

        var text3: String?
        text3 ?= nil
        XCTAssertEqual(text3, nil)

        var text4: String? = "text4"
        text4 ?= nil
        XCTAssertEqual(text4, "text4")
    }

    func testIsNilOrEmpty() {
        let nilArray: [String]? = nil
        XCTAssertTrue(nilArray.isNilOrEmpty)

        let emptyArray: [String]? = []
        XCTAssertTrue(emptyArray.isNilOrEmpty)

        let intArray: [Int]? = [1]
        XCTAssertFalse(intArray.isNilOrEmpty)

        let optionalArray: [Int]? = [1]
        XCTAssertFalse(optionalArray.isNilOrEmpty)

        let nilString: String? = nil
        XCTAssert(nilString.isNilOrEmpty)

        let emptyString: String? = ""
        XCTAssert(emptyString.isNilOrEmpty)

        let string: String? = "hello World!"
        XCTAssertFalse(string.isNilOrEmpty)
    }

    func testNonEmpty() {
        let nilCollection: [Int]? = nil
        XCTAssertNil(nilCollection.nonEmpty)

        let emptyCollection: [Int]? = []
        XCTAssertNil(emptyCollection.nonEmpty)

        let collection: [Int]? = [1, 2, 3]
        XCTAssertNotNil(collection.nonEmpty)
        XCTAssertEqual(collection.nonEmpty!, [1, 2, 3])
    }
    
    func testIsNilOrZero() {
        let nilInteger: Int? = nil
        XCTAssertTrue(nilInteger.isNilOrZero)
        
        let zeroInteger: Int? = 0
        XCTAssertTrue(zeroInteger.isNilOrZero)
        
        let integer: Int? = 1
        XCTAssertFalse(integer.isNilOrZero)
        
        let nilFloating: Double? = nil
        XCTAssertTrue(nilFloating.isNilOrZero)
        
        let zeroFloating: Double? = 0
        XCTAssertTrue(zeroFloating.isNilOrZero)
        
        let floating: Double? = 1.11
        XCTAssertFalse(floating.isNilOrZero)
    }
    
    func testNonZero() {
        let nilInteger: Int? = nil
        XCTAssertNil(nilInteger.nonZero)
        
        let zeroInteger: Int? = 0
        XCTAssertNil(zeroInteger.nonZero)
        
        let integer: Int? = 1
        XCTAssertNotNil(integer.nonZero)
        XCTAssertEqual(integer.nonZero!, 1)
        
        let nilFloating: Double? = nil
        XCTAssertNil(nilFloating.nonZero)
        
        let zeroFloating: Double? = 0
        XCTAssertNil(zeroFloating.nonZero)
        
        let floating: Double? = 1.11
        XCTAssertNotNil(floating.nonZero)
        XCTAssertEqual(floating.nonZero!, 1.11)
    }

}
