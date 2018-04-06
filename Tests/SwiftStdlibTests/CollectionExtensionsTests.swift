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

    let collection = [1, 2, 3, 4, 5]

	func testForEachInParallel() {
		collection.forEachInParallel { item in
			XCTAssert(collection.contains(item))
		}
	}

	func testSafeSubscript() {
		XCTAssertNotNil(collection[safe: 2])
		XCTAssertEqual(collection[safe: 2], 3)
		XCTAssertNil(collection[safe: 10])
	}

	func testRandomItem() {
		XCTAssertNotNil([1, 2, 3].randomItem)
		XCTAssert([1, 2, 3].contains([1, 2, 3].randomItem!))
		XCTAssertNil([].randomItem)
	}

    func testAverage() {
        XCTAssertEqual(collection.average(), 3)
        XCTAssertEqual([Int]().average(), 0)
    }

}
