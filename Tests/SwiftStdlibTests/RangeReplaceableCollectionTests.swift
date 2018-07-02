//
//  RangeReplaceableCollectionTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 7/2/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

class RangeReplaceableCollectionTests: XCTestCase {

    func testRotated() {
        let array: [Int] = [1, 2, 3, 4]
        XCTAssertEqual(array.rotated(by: 0), [1, 2, 3, 4])
        XCTAssertEqual(array.rotated(by: 5), [4, 1, 2, 3])
        XCTAssertEqual(array.rotated(by: 4), [1, 2, 3, 4])
        XCTAssertEqual(array.rotated(by: 1), [4, 1, 2, 3])
        XCTAssertEqual(array.rotated(by: 3), [2, 3, 4, 1])
        XCTAssertEqual(array.rotated(by: -1), [2, 3, 4, 1])
        XCTAssertEqual(array.rotated(by: -3), [4, 1, 2, 3])
        XCTAssertEqual(array.rotated(by: -5), [2, 3, 4, 1])

    }

    func testRotate() {
        var array: [Int] = [1, 2, 3, 4]
        array.rotate(by: 0)
        XCTAssertEqual(array, [1, 2, 3, 4])
        array.rotate(by: 2)
        XCTAssertEqual(array, [3, 4, 1, 2])
        array.rotate(by: -1)
        XCTAssertEqual(array, [4, 1, 2, 3])
    }
}
