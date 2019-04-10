//
//  SequenceExtensionsTests.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 04/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

private enum SequenceTestError: Error {
    case closureThrows
}

final class SequenceExtensionsTests: XCTestCase {

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

    func testLastWhere() {
        let array = [1, 1, 2, 1, 1, 1, 2, 1, 4, 1]
        let element = array.last { $0 % 2 == 0 }
        XCTAssertEqual(element, 4)
        XCTAssertNil([Int]().last { $0 % 2 == 0 })
    }

    func testRejectWhere() {
        let input = [1, 2, 3, 4, 5]
        let output = input.reject { $0 % 2 == 0 }
        XCTAssertEqual(output, [1, 3, 5])
    }

    func testCountWhere() {
        let array = [1, 1, 1, 1, 4, 4, 1, 1, 1]
        let count = array.count { $0 % 2 == 0 }
        XCTAssertEqual(count, 2)
    }

    func testForEachReversed() {
        let input = [1, 2, 3, 4, 5]
        var output: [Int] = []
        input.forEachReversed { output.append($0) }
        XCTAssertEqual(output.first, 5)
    }

    func testForEachWhere() {
        let input = [1, 2, 2, 2, 1, 4, 1]
        var output: [Int] = []
        input.forEach(where: {$0 % 2 == 0}, body: { output.append($0 * 2) })
        XCTAssertEqual(output, [4, 4, 4, 8])
    }

    func testAccumulate() {
        let input = [1, 2, 3]
        let result = input.accumulate(initial: 0, next: +)
        XCTAssertEqual([1, 3, 6], result)
    }

    func testFilteredMap() {
        let input = [1, 2, 3, 4, 5]
        let result = input.filtered({ $0 % 2 == 0 }, map: { $0.string })
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(["2", "4"], result)
    }

    func testSingle() {
        XCTAssertNil([].single(where: { _ in true }))
        XCTAssertEqual([4].single(where: { _ in true }), 4)
        XCTAssertNil([2, 4].single(where: { _ in true }))
        XCTAssertEqual([1, 4, 7].single(where: { $0 % 2 == 0 }), 4)
        XCTAssertNil([2, 2, 4, 7].single(where: { $0 % 2 == 0 }))
        XCTAssertThrowsError(try [2].single(where: { _ in throw SequenceTestError.closureThrows }))
    }

    func testWithoutDuplicates() {
        XCTAssertEqual([1, 2, 1, 3, 2].withoutDuplicates { $0 }, [1, 2, 3])
        XCTAssertEqual([[1, 4], [2, 2], [1, 3], [3, 2], [2, 1]].withoutDuplicates { $0[0] }, [[1, 4], [2, 2], [3, 2]])
    }

    func testContains() {
        XCTAssert([Int]().contains([]))
        XCTAssertFalse([Int]().contains([1, 2]))
        XCTAssert([1, 2, 3].contains([1, 2]))
        XCTAssert([1, 2, 3].contains([2, 3]))
        XCTAssert([1, 2, 3].contains([1, 3]))
        XCTAssertFalse([1, 2, 3].contains([4, 5]))
    }

    func testContainsDuplicates() {
        XCTAssertFalse([String]().containsDuplicates())
        XCTAssert(["a", "b", "b", "c"].containsDuplicates())
        XCTAssertFalse(["a", "b", "c", "d"].containsDuplicates())
    }

    func testDuplicates() {
        XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].duplicates().sorted(), [1, 2, 3])
        XCTAssertEqual(["h", "e", "l", "l", "o"].duplicates().sorted(), ["l"])
    }

    func testSum() {
        XCTAssertEqual([1, 2, 3, 4, 5].sum(), 15)
        XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].sum(), 17)
    }

}
