//
//  ArrayExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/26/16.
//  Copyright © 2016 SwifterSwift
//
import XCTest
@testable import SwifterSwift

final class ArrayExtensionsTests: XCTestCase {

    func testPrepend() {
        var arr = [2, 3, 4, 5]
        arr.prepend(1)
        XCTAssertEqual(arr, [1, 2, 3, 4, 5])
    }

    func testSafeSwap() {
        var array: [Int] = [1, 2, 3, 4, 5]
        array.safeSwap(from: 3, to: 0)
        XCTAssertEqual(array[3], 1)
        XCTAssertEqual(array[0], 4)

        var newArray = array
        newArray.safeSwap(from: 1, to: 1)
        XCTAssertEqual(newArray, array)

        newArray = array
        newArray.safeSwap(from: 1, to: 12)
        XCTAssertEqual(newArray, array)

        let emptyArray: [Int] = []
        var swappedEmptyArray = emptyArray
        swappedEmptyArray.safeSwap(from: 1, to: 3)
        XCTAssertEqual(swappedEmptyArray, emptyArray)
    }

    func testSortedLike() {
        let order1 = [1, 2, 3, 4, 5]
        let candidate1 = [2, 5, 3, 1, 4]
        XCTAssertEqual(candidate1.sorted(like: order1, keyPath: \.self), order1)

        let candidate2 = [2, 5, 3, 6, 1, 4]
        XCTAssertEqual(candidate2.sorted(like: order1, keyPath: \.self), [1, 2, 3, 4, 5, 6])

        // swiftlint:disable:next nesting
        struct TestStruct { let prop: String }
        let order3 = ["1", "2", "3", "4", "5"]
        let candidate3 = [TestStruct(prop: "3"), TestStruct(prop: "2"), TestStruct(prop: "2"), TestStruct(prop: "1"), TestStruct(prop: "3")]
        XCTAssertEqual(candidate3.sorted(like: order3, keyPath: \.prop).map { $0.prop }, ["1", "2", "2", "3", "3"])
    }

    func testRemoveAll() {
        var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll(0)
        XCTAssertEqual(arr, [1, 2, 3, 4, 5])
        arr = []
        arr.removeAll(0)
        XCTAssertEqual(arr, [])
    }

    func testRemoveAllItems() {
        var arr = [0, 1, 2, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll([0, 2])
        XCTAssertEqual(arr, [1, 3, 4, 5])
        arr.removeAll([])
        XCTAssertEqual(arr, [1, 3, 4, 5])
        arr = []
        arr.removeAll([])
        XCTAssertEqual(arr, [])
    }

    func testRemoveDuplicates() {
        var array = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        array.removeDuplicates()
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
    }

    func testWithoutDuplicates() {
        XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates(), [1, 2, 3, 4, 5])
        XCTAssertEqual(["h", "e", "l", "l", "o"].withoutDuplicates(), ["h", "e", "l", "o"])
    }

    func testWithoutDuplicatesUsingKeyPath() {
        let array = [Person(name: "Wade", age: 20, location: Location(city: "London")), Person(name: "James", age: 32), Person(name: "James", age: 36), Person(name: "Rose", age: 29), Person(name: "James", age: 72, location: Location(city: "Moscow")), Person(name: "Rose", age: 56), Person(name: "Wade", age: 22, location: Location(city: "Prague"))]
        let arrayWithoutDuplicatesHashable = array.withoutDuplicates(keyPath: \.name)
        let arrayWithoutDuplicatesHashablePrepared = [Person(name: "Wade", age: 20, location: Location(city: "London")), Person(name: "James", age: 32), Person(name: "Rose", age: 29)]
        XCTAssertEqual(arrayWithoutDuplicatesHashable, arrayWithoutDuplicatesHashablePrepared)
        let arrayWithoutDuplicatesNHashable = array.withoutDuplicates(keyPath: \.location)
        let arrayWithoutDuplicatesNHashablePrepared = [Person(name: "Wade", age: 20, location: Location(city: "London")), Person(name: "James", age: 32), Person(name: "James", age: 72, location: Location(city: "Moscow")), Person(name: "Wade", age: 22, location: Location(city: "Prague"))]
        XCTAssertEqual(arrayWithoutDuplicatesNHashable, arrayWithoutDuplicatesNHashablePrepared)
    }
}
