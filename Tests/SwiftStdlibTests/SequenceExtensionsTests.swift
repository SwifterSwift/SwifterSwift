//
//  SequenceExtensionsTests.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 04/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

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

}
