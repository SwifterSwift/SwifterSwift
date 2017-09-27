//
//  SwifterSwiftTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//
import XCTest
@testable import SwifterSwift

class SwifterSwiftTests: XCTestCase {
	
	func testTypeName() {
		let number = 8
		XCTAssertEqual(SwifterSwift.typeName(for: number), "Int")
	}

	func testDelay() {
		var value = 0
		let done = expectation(description: "Execute block after delay")

		SwifterSwift.delay(milliseconds: 50, queue: DispatchQueue.main, completion: {
			value = 1
			done.fulfill()
		})

		XCTAssertEqual(value, 0, "Does not get executed right away")

		waitForExpectations(timeout: 2, handler: { _ in
			XCTAssertEqual(value, 1, "Value was incremented after delay")
		})
	}

	func testDebounce() {
		var value = 0
		let done = expectation(description: "Execute block after delay")

		func incrementor() {
			value += 1
		}

		let debouncedIncrementor = SwifterSwift.debounce(millisecondsDelay: 20, action: {
			incrementor()
		})

		for i in 1...10 {
			debouncedIncrementor()
			if i == 10 {
				SwifterSwift.delay(milliseconds: 30, completion: {
					done.fulfill()
				})
			}
		}

		XCTAssertEqual(value, 0, "Debounced function does not get executed right away")

		waitForExpectations(timeout: 2, handler: { _ in
			XCTAssertEqual(value, 1, "Value was incremented only once")
		})
	}
	
}
