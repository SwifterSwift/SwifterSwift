//
//  ArrayExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/26/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//
import XCTest
@testable import SwifterSwift

class ArrayExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testRandomItem() {
		XCTAssert([1, 2, 3].contains([1, 2, 3].randomItem))
	}
	
	func testAverage() {
		XCTAssertEqual([1, 2, 3, 4, 5].average, 3)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average, 3.4)
		XCTAssertEqual([Int]().average, 0)
		XCTAssertEqual([Double]().average, 0)
	}
	
	func testFirstIndex() {
		XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2))
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2)!, 2)
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 7))
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: "7"))
	}
	
	func testIndexes() {
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indexes(of: 1), [0, 1, 5, 7])
	}
	
	func testLastIndex() {
		XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2))
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2)!, 6)
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 7))
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: "7"))
	}
	
	func testPop() {
		var arr = [1, 2, 3, 4, 5]
		let item = arr.pop()
		XCTAssertEqual(arr, [1, 2, 3, 4])
		XCTAssertNotNil(item)
		XCTAssertEqual(item, 5)
		arr.removeAll()
		XCTAssertNil(arr.pop())
	}
	
	func testPrepend() {
		var arr = [2, 3, 4, 5]
		arr.prepend(1)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
	
	func testPush() {
		var arr = [1, 2, 3, 4]
		arr.push(5)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
	
	func testRemoveAll() {
		var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
		arr.removeAll(0)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
	
	func testRemoveDuplicates() {
		var arr = [1, 2, 1, 3, 4, 5, 1, 1]
		arr.removeDuplicates()
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
	
	func testShuffle() {
		for _ in 1...1000 {
			var arr = [1, 2, 3, 4, 5]
			arr.shuffle()
			XCTAssertEqual(arr.count, 5)
			XCTAssertNotEqual(arr, [1, 2, 3, 4, 5])
		}
	}
	
	func testShuffled() {
		XCTAssertEqual([1, 2, 3, 4, 5].shuffled.count, 5)
		XCTAssertNotEqual([1, 2, 3, 4, 5].shuffled, [1, 2, 3, 4, 5])
	}
	
	func testSum() {
		XCTAssertEqual([1, 2, 3, 4, 5].sum, 15)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].sum, 17)
	}
	
	func testWithoutDuplicates() {
		XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates, [1, 2, 3, 4, 5])
	}
	
	func testItemAtIndex() {
		XCTAssertEqual([1, 2, 3].item(at: 0), 1)
		XCTAssertEqual([1, 2, 3].item(at: 1), 2)
		XCTAssertEqual([1, 2, 3].item(at: 2), 3)
		XCTAssertNil([1, 2, 3].item(at: 5))
	}
	
	func testContains() {
		XCTAssert([Int]().contains([]))
		XCTAssertFalse([Int]().contains([1, 2]))
		XCTAssert([1, 2, 3].contains([1, 2]))
		XCTAssert([1, 2, 3].contains([2, 3]))
		XCTAssert([1, 2, 3].contains([1, 3]))
		XCTAssertFalse([1, 2, 3].contains([4, 5]))
	}
	
}
