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
    
    func testAllMatch() {
        let collection = [2, 4, 6, 8, 10, 12]
        XCTAssert(collection.all { $0 % 2 == 0 })
    }
    
    func testAnyMatch() {
        let collection = [3, 5, 8, 9, 11, 13]
        XCTAssert(collection.any { $0 % 2 == 0 })
    }
    
    func testNoneMatch() {
        let collection = [3, 5, 7, 9, 11, 13]
        XCTAssert(collection.none { $0 % 2 == 0 })
    }
}
