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
		XCTAssert([1, 2, 3, 4, 5].average == 3, "Couldn't get correct value for \(#function)")
		XCTAssert([1.2, 2.3, 3.4, 4.5, 5.6].average == 3.4, "Couldn't get correct value for \(#function)")
	}
	
	func testFirstIndex() {
		XCTAssert([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2)! == 2, "Couldn't get correct value for \(#function)")
	}
	
	func testIndexes() {
		XCTAssert([1, 1, 2, 3, 4, 1, 2, 1].indexes(of: 1) == [0, 1, 5, 7], "Couldn't get correct value for \(#function)")
	}
	
	func testLastIndex() {
		XCTAssert([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2) == 6, "Couldn't get correct value for \(#function)")
	}
	
	func testPop() {
		var arr = [1, 2, 3, 4, 5]
		let item = arr.pop()
		XCTAssert(arr == [1, 2, 3, 4] && item! == 5, "Couldn't get correct value for \(#function)")
	}
	
	func testPrepend() {
		var arr = [2, 3, 4, 5]
		arr.prepend(1)
		XCTAssert(arr == [1, 2, 3, 4, 5], "Couldn't get correct value for \(#function)")
	}
	
	func testPush() {
		var arr = [1, 2, 3, 4]
		arr.push(5)
		XCTAssert(arr == [1, 2, 3, 4, 5], "Couldn't get correct value for \(#function)")
	}
	
	func testRemoveAll() {
		var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
		arr.removeAll(0)
		XCTAssert(arr == [1, 2, 3, 4, 5], "Couldn't get correct value for \(#function)")
	}
	
	func testRemoveDuplicates() {
		var arr = [1, 2, 1, 3, 4, 5, 1, 1]
		arr.removeDuplicates()
		XCTAssert(arr == [1, 2, 3, 4, 5], "Couldn't get correct value for \(#function)")
	}
	
	func testShuffle() {
		var arr = [1, 2, 3, 4, 5]
		arr.shuffle()
		XCTAssert(arr != [1, 2, 3, 4, 5] && arr.count == 5, "Couldn't get correct value for \(#function)")
	}
	
	func testShuffled() {
		XCTAssert([1, 2, 3, 4, 5].shuffled != [1, 2, 3, 4, 5], "Couldn't get correct value for \(#function)")
	}
	
	func testSum() {
		XCTAssert([1, 2, 3, 4, 5].sum == 15, "Couldn't get correct value for \(#function)")
		XCTAssert([1.2, 2.3, 3.4, 4.5, 5.6].sum == 17, "Couldn't get correct value for \(#function)")
	}
	
	func testUniqueValues() {
		XCTAssert([1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates == [1, 2, 3, 4, 5], "Couldn't get correct value for \(#function)")
	}
}
