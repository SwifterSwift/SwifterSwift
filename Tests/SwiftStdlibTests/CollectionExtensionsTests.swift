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

    func testFirstIndexWhere() {
        let array = [1, 7, 1, 2, 4, 1, 6]
        let index = array.firstIndex { $0 % 2 == 0 }
        XCTAssertEqual(index, 3)
        XCTAssertNil([Int]().firstIndex { $0 % 2 == 0 })
    }

    func testLastIndexWhere() {
        let array = [1, 1, 1, 2, 2, 1, 1, 2, 1]
        let index = array.lastIndex { $0 % 2 == 0 }
        XCTAssertEqual(index, 7)
        XCTAssertNil(array.lastIndex { $0 == 3 })
        XCTAssertNil([Int]().lastIndex { $0 % 2 == 0 })
    }

    func testIndicesWhere() {
        let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let indices = array.indices { $0 % 2 == 0 }
        XCTAssertEqual(indices!, [0, 2, 4, 6, 8])
        let emptyArray: [Int] = []
        let emptyIndices = emptyArray.indices { $0 % 2 == 0 }
        XCTAssertNil(emptyIndices)
    }

    func testAverage() {
        XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average(), 3.4)
        XCTAssertEqual([Double]().average(), 0)
    }

}
