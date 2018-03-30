//
//  CollectionExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class CollectionExtensionsTests: XCTestCase {
	
	func testForEachInParallel() {
		let collection = [1, 2, 3, 4, 5]
		collection.forEachInParallel { item in
			XCTAssert(collection.contains(item))
		}
	}
	
	func testSafeSubscript() {
		let collection = [1, 2, 3, 4, 5]
		XCTAssertNotNil(collection[safe: 2])
		XCTAssertEqual(collection[safe: 2], 3)
		XCTAssertNil(collection[safe: 10])
	}
	
    func testRandomItem() {
        XCTAssertNotNil([1, 2, 3].randomItem)
        XCTAssert([1, 2, 3].contains([1, 2, 3].randomItem!))
        XCTAssertNil([].randomItem)
    }
    
    func testContainsAllWithCondition() {
        let collection = [1, 2, 2, 2, 3, 4, 3, 2, 1, 2, 2]
        XCTAssertFalse(collection.all { return $0%2 == 0 })
    }
    
    func testContainsAnyWithCondition() {
        let collection = [1, 2, 2, 2, 3, 4, 3, 2, 1, 2, 2]
        XCTAssertTrue(collection.any { return $0%2 == 0 })
    }
    
    func testContainsNoneWithCondition() {
        let collection = [1, 2, 2, 2, 3, 4, 3, 2, 1, 2, 2]
        XCTAssertFalse(collection.none { return $0%2 == 0 })
    }
}
