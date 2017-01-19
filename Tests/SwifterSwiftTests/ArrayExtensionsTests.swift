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
	
	func testAverage() {
		XCTAssertEqual([1, 2, 3, 4, 5].average, 3)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average, 3.4)
	}
	
	func testFirstIndex() {
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2)!, 2)
	}
	
	func testIndexes() {
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indexes(of: 1), [0, 1, 5, 7])
	}
	
	func testLastIndex() {
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2), 6)
	}
	
	func testPop() {
		var arr = [1, 2, 3, 4, 5]
		let item = arr.pop()
		XCTAssertEqual(arr, [1, 2, 3, 4])
		XCTAssertNotNil(item)
		XCTAssertEqual(item, 5)
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
		var arr = [1, 2, 3, 4, 5]
		arr.shuffle()
		XCTAssertTrue(arr.count == 5)
		XCTAssertNotEqual(arr, [1, 2, 3, 4, 5])
	}
	
	func testShuffled() {
		XCTAssertNotEqual([1, 2, 3, 4, 5].shuffled, [1, 2, 3, 4, 5])
	}
	
	func testSum() {
		XCTAssertEqual([1, 2, 3, 4, 5].sum, 15)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].sum, 17)
	}
	
	func testUniqueValues() {
		XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates, [1, 2, 3, 4, 5])
	}
}
