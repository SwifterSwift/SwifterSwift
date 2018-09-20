//
//  RandomAccessCollectionExtensionsTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 7/14/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class RandomAccessCollectionExtensionsTests: XCTestCase {

    func testIndices() {
        XCTAssertEqual([].indices(of: 5), [])
        XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indices(of: 5), [])
        XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indices(of: 1), [0, 1, 5, 7])
        XCTAssertEqual(["a", "b", "c", "b", "4", "1", "2", "1"].indices(of: "b"), [1, 3])
    }

}
