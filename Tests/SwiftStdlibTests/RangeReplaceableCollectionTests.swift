//
//  RangeReplaceableCollectionTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 7/2/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class RangeReplaceableCollectionTests: XCTestCase {

    func testInitExpressionOfSize() {
        var array = [1, 2, 3]
        let newArray = [Int](expression: array.removeLast(), count: array.count)
        XCTAssertEqual(newArray, [3, 2, 1])
        XCTAssertTrue(array.isEmpty)
        let empty = [Int](expression: 1, count: 0)
        XCTAssertTrue(empty.isEmpty)

    }

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

    func testRemoveWhere() {
        var array = [0, 1, 2, 0, 3, 4, 5, 0, 0]
        array.removeFirst { $0 == 1 }
        XCTAssertEqual(array, [0, 2, 0, 3, 4, 5, 0, 0])
        array = []
        XCTAssertNil(array.removeFirst { $0 == 10 })
        array = [2, 2, 1, 2, 3]
        let removedElement = array.removeFirst { $0 == 2 }
        XCTAssertEqual(array, [2, 1, 2, 3])
        XCTAssertEqual(removedElement, 2)

        XCTAssertThrowsError(try array.removeFirst(where: { _ in throw NSError(domain: "", code: -1, userInfo: nil) }))
    }

    func testRemoveRandomElement() {
        var emptyArray = [Int]()
        XCTAssertNil(emptyArray.removeRandomElement())

        var array = [1, 2, 3]
        let elements = array.count
        let removedElement = array.removeRandomElement()!
        XCTAssertEqual(elements - 1, array.count)
        XCTAssertFalse(array.contains(removedElement))
    }

    func testKeepWhile() {
        var input = [2, 4, 6, 7, 8, 9, 10]
        input.keep(while: {$0 % 2 == 0 })
        XCTAssertEqual(input, [2, 4, 6])

        input = [7, 7, 8, 10]
        input.keep(while: {$0 % 2 == 0 })
        XCTAssertEqual(input, [Int]())
    }

    func testTakeWhile() {
        var input = [2, 4, 6, 7, 8, 9, 10]
        var output = input.take(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [2, 4, 6])

        input = [7, 7, 8, 10]
        output = input.take(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [Int]())

        XCTAssertEqual([].take(while: {$0 % 2 == 0 }), [])
    }

    func testSkipWhile() {
        var input = [2, 4, 6, 7, 8, 9, 10]
        var output = input.skip(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [7, 8, 9, 10])

        input = [7, 7, 8, 10]
        output = input.skip(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [7, 7, 8, 10])

        XCTAssertEqual([].skip(while: { $0 % 2 == 0}), [])
    }

    func testRemoveDuplicatesUsingKeyPathHashable() {
        var input = [Person(name: "Wade", age: 20, location: Location(city: "London")),
                     Person(name: "James", age: 32),
                     Person(name: "James", age: 36),
                     Person(name: "Rose", age: 29),
                     Person(name: "James", age: 72, location: Location(city: "Moscow")),
                     Person(name: "Rose", age: 56),
                     Person(name: "Wade", age: 22, location: Location(city: "Prague"))]

        let expectedResult = [Person(name: "Wade", age: 20, location: Location(city: "London")),
                              Person(name: "James", age: 32),
                              Person(name: "Rose", age: 29)]

        input.removeDuplicates(keyPath: \.name)
        XCTAssertEqual(input, expectedResult)
    }

    func testRemoveDuplicatesUsingKeyPathEquatable() {
        var input = [Person(name: "Wade", age: 20, location: Location(city: "London")),
                     Person(name: "James", age: 32),
                     Person(name: "James", age: 36),
                     Person(name: "Rose", age: 29),
                     Person(name: "James", age: 72, location: Location(city: "Moscow")),
                     Person(name: "Rose", age: 56),
                     Person(name: "Wade", age: 22, location: Location(city: "Prague"))]

        let expectedResult = [Person(name: "Wade", age: 20, location: Location(city: "London")),
                              Person(name: "James", age: 32),
                              Person(name: "James", age: 72, location: Location(city: "Moscow")),
                              Person(name: "Wade", age: 22, location: Location(city: "Prague"))]

        input.removeDuplicates(keyPath: \.location)
        XCTAssertEqual(input, expectedResult)
    }

    func testIntSubscripts() {
        var string = "Hello world!"
        XCTAssertEqual(string[0], "H")
        XCTAssertEqual(string[11], "!")

        XCTAssertEqual(string[0..<5], "Hello")
        XCTAssertEqual(string[6..<12], "world!")

        XCTAssertEqual(string[0...4], "Hello")
        XCTAssertEqual(string[6...11], "world!")

        XCTAssertEqual(string[0...], "Hello world!")

        XCTAssertEqual(string[...11], "Hello world!")

        XCTAssertEqual(string[..<12], "Hello world!")

        string[0] = "h"
        XCTAssertEqual(string, "hello world!")
        string[11] = "?"
        XCTAssertEqual(string, "hello world?")

        string[0..<5] = "Goodbye"
        XCTAssertEqual(string, "Goodbye world?")
        string[8..<14] = "planet!"
        XCTAssertEqual(string, "Goodbye planet!")

        string[0...6] = "Hello"
        XCTAssertEqual(string, "Hello planet!")
        string[6...12] = "world?"
        XCTAssertEqual(string, "Hello world?")

        string[5...] = "!"
        XCTAssertEqual(string, "Hello!")

        string[..<6] = "Hello Ferris"
        XCTAssertEqual(string, "Hello Ferris")

        string[...4] = "Save"
        XCTAssertEqual(string, "Save Ferris")
    }

}
