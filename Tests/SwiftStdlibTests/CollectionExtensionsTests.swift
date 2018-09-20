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

    func testForEachSlice() {
        var iterations: Int = 0

        // A slice with value zero
        var array: [String] = ["james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        array.forEach(slice: 0) { _ in
            iterations += 1
        }
        XCTAssertEqual(iterations, 0)

        // A slice that divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq"]

        array.forEach(slice: 2) { (sliceArray) in
            switch iterations {
            case 0:
                XCTAssertEqual(sliceArray, [ "james", "irving" ])
            case 1:
                XCTAssertEqual(sliceArray, [ "jordan", "jonshon" ])
            case 2:
                XCTAssertEqual(sliceArray, [ "iverson", "shaq" ])
            default: break
            }
            iterations += 1
        }

        // A slice that does not divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq", "bird"]

        iterations = 0

        array.forEach(slice: 2) { (sliceArray) in
            switch iterations {
            case 0:
                XCTAssertEqual(sliceArray, [ "james", "irving" ])
            case 1:
                XCTAssertEqual(sliceArray, [ "jordan", "jonshon" ])
            case 2:
                XCTAssertEqual(sliceArray, [ "iverson", "shaq" ])
            case 3:
                XCTAssertEqual(sliceArray, [ "bird" ])
            default: break
            }
            iterations += 1
        }

        // A slice greater than the array count
        array = [ "james", "irving", "jordan", "jonshon" ]
        array.forEach(slice: 6) { (sliceArray) in
            XCTAssertEqual(sliceArray, [ "james", "irving", "jordan", "jonshon"])
        }
    }

    func testGroupBySize() {

        // A slice with value zero
        var array: [String] = ["james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        var slices = array.group(by: 0)
        XCTAssertNil(slices)

        // A slice that divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        slices = array.group(by: 2)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 3)

        // A slice that does not divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq", "bird"]
        slices = array.group(by: 2)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 4)

        // A slice greater than the array count
        array = [ "james", "irving", "jordan", "jonshon" ]
        slices = array.group(by: 6)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 1)
    }

    func testFirstIndex() {
        XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2))
        XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2), 2)
        XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 7))
    }

    func testLastIndex() {
        XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2))
        XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2), 6)
        XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 7))
    }

    func testAverage() {
        XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average(), 3.4)
        XCTAssertEqual([Double]().average(), 0)

        XCTAssertEqual([1, 2, 3, 4, 5].average(), 3)
        XCTAssertEqual([Int]().average(), 0)
    }

}
