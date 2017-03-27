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

	func testRandomItem() {
		XCTAssert([1, 2, 3].contains([1, 2, 3].randomItem))
	}
	
	func testAverage() {
		XCTAssertEqual([1, 2, 3, 4, 5].average(), 3)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average(), 3.4)
		XCTAssertEqual([Int]().average(), 0)
		XCTAssertEqual([Double]().average(), 0)
	}
	
	func testFirstIndex() {
		XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2))
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2)!, 2)
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 7))
	}
	
	func testIndexes() {
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indexes(of: 1), [0, 1, 5, 7])
	}
	
	func testLastIndex() {
		XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2))
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2)!, 6)
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 7))
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
	
    func testSwap() {
        var array: [Int] = [1, 2, 3, 4, 5]
        array.swap(from: 3, to: 0)
        XCTAssertEqual(array[3], 1)
        XCTAssertEqual(array[0], 4)
    }
    
    func testSafeSwap() {
        var array: [Int] = [1, 2, 3, 4, 5]
        array.safeSwap(from: 3, to: 0)
        XCTAssertEqual(array[3], 1)
        XCTAssertEqual(array[0], 4)
		
		var newArray = array
		newArray.safeSwap(from: 1, to: 1)
		XCTAssertEqual(newArray, array)
		
		
		newArray = array
		newArray.safeSwap(from: 1, to: 12)
		XCTAssertEqual(newArray, array)
		
		let emptyArray: [Int] = []
		var swappedEmptyArray = emptyArray
		swappedEmptyArray.safeSwap(from: 1, to: 3)
		XCTAssertEqual(swappedEmptyArray, emptyArray)
		
    }
    
	func testRemoveAll() {
		var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
		arr.removeAll(0)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
    
    func testRemoveAllItems() {
        var arr = [0, 1, 2, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll([0,2])
        XCTAssertEqual(arr, [1, 3, 4, 5])
    }
    
	
    func testShuffle() {
		var arr = ["a"]
		arr.shuffle()
		XCTAssertEqual(arr, arr)
		
        let original = [1, 2, 3, 4, 5]
        var array = original
        
        while original == array {
            array.shuffle()
        }
        XCTAssertEqual(array.count, 5)
        XCTAssertNotEqual(original, array)
    }
    
    func testShuffled() {
        let original = [1, 2, 3, 4, 5]
        var array = original
        
        while original == array {
            array = array.shuffled()
        }
        XCTAssertEqual(array.count, 5)
        XCTAssertNotEqual(original, array)
    }
	
	func testSum() {
		XCTAssertEqual([1, 2, 3, 4, 5].sum(), 15)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].sum(), 17)
	}
	
    func testRemoveDuplicates() {
        var array = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        array.removeDuplicates()
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
    }
    
    func testDuplicatesRemoved() {
        XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved(), [1, 2, 3, 4, 5])
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
