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
	
	func testObjectForKey() {
		SwifterSwift.set(true, forKey: "test")
		let bool = SwifterSwift.object(forKey: "test") as? Bool
		XCTAssertNotNil(bool)
		XCTAssertEqual(bool, true)
	}
	
	func testStringForKey() {
		SwifterSwift.set("hello", forKey: "string")
		let string = SwifterSwift.string(forKey: "string")
		XCTAssertNotNil(string)
		XCTAssertEqual(string, "hello")
	}
	
	func testIntegerForKey() {
		SwifterSwift.set(1, forKey: "int")
		let int = SwifterSwift.integer(forKey: "int")
		XCTAssertNotNil(int)
		XCTAssertEqual(int, 1)
	}
	
	func testDoubleForKey() {
		SwifterSwift.set(1.32, forKey: "double")
		let double = SwifterSwift.double(forKey: "double")
		XCTAssertNotNil(double)
		XCTAssertEqual(double, 1.32)
	}
	
	func testDataForKey() {
		let stringData = "hello".data(using: .utf8)!
		SwifterSwift.set(stringData, forKey: "data")
		let data = SwifterSwift.data(forKey: "data")
		XCTAssertNotNil(data)
		XCTAssertEqual(data, stringData)
	}
	
	func testBoolForKey() {
		SwifterSwift.set(true, forKey: "test")
		let bool = SwifterSwift.bool(forKey: "test")
		XCTAssertNotNil(bool)
		XCTAssertEqual(bool, true)
	}
	
	func testArrayForKey() {
		SwifterSwift.set([1, 2, 3], forKey: "array")
		let array = SwifterSwift.array(forKey: "array") as? [Int]
		XCTAssertNotNil(array)
		XCTAssertEqual(array!, [1, 2, 3])
	}
	
	func testDictForKey() {
		SwifterSwift.set(["key": 1], forKey: "dict")
		let dict = SwifterSwift.dictionary(forKey: "dict") as? [String: Int]
		XCTAssertNotNil(dict)
		XCTAssertEqual(dict!, ["key": 1])
	}
	
	func testFloatForKey() {
		SwifterSwift.set(Float(1.32), forKey: "float")
		let float = SwifterSwift.float(forKey: "float")
		XCTAssertNotNil(float)
		XCTAssertEqual(float, Float(1.32))
	}
	
	func testUserDefaults() {
		XCTAssertEqual(SwifterSwift.userDefaults, UserDefaults.standard)
	}
	
}
