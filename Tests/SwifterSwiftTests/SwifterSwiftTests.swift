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
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testTypeName() {
		let number = 8
		XCTAssert(SwifterSwift.typeName(for: number) == "Int", "Couldn't get correct value for \(#function)")
	}

	func testDelay() {
		var value = 0
		let done = expectation(description: "Execute block after delay")

		SwifterSwift.delay(miliseconds: 500, queue: DispatchQueue.main, completion: {
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

		let debouncedIncrementor = SwifterSwift.debounce(milisecondsDelay: 200, action: {
			incrementor()
		})

		for i in 1...10 {
			debouncedIncrementor()
			if i == 10 {
				SwifterSwift.delay(miliseconds: 300, completion: {
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
