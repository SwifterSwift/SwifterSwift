//
//  MutableCollectionTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 21/09/19.
//  Copyright © 2019 SwifterSwift
//

import XCTest

@testable import SwifterSwift

final class MutableCollectionTests: XCTestCase {

    func testKeyPathSort() {
        var array = ["James", "Wade", "Bryant"]
        array.sort(by: \String.count, with: <)
        XCTAssertEqual(array, ["Wade", "James", "Bryant"])
        array.sort(by: \String.count, with: >)
        XCTAssertEqual(array, ["Bryant", "James", "Wade"])

        // Comparable version
        array.sort(by: \String.count)
        XCTAssertEqual(array, ["Wade", "James", "Bryant"])

        // Testing optional keyPath
        let optionalCompare = { (char1: Character?, char2: Character?) -> Bool in
          guard let char1 = char1, let char2 = char2 else { return false }
          return char1 < char2
        }

        var array2 = ["James", "Wade", "Bryant", ""]
        array2.sort(by: \String.first, with: optionalCompare)
        XCTAssertEqual(array2, ["Bryant", "James", "Wade", ""])
    }

    func testAssignToAll() {
        var collection: [TestStruct] = [1, 2, 3, 4, 5]
        collection.assignToAll(value: 0, by: \.testField)
        let expectedCollection: [TestStruct] = [0, 0, 0, 0, 0]
        XCTAssertEqual(collection, expectedCollection)

        // check with an empty collection
        var initialEmptyCollection: [TestStruct] = []
        initialEmptyCollection.assignToAll(value: 5, by: \.testField)
        let expectedEmptyCollection: [TestStruct] = []
        XCTAssertEqual(initialEmptyCollection, expectedEmptyCollection)
    }
}
