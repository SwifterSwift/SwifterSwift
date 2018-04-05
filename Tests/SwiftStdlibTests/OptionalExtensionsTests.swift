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
		var str: String? = nil
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
		var str: String? = nil
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

}
