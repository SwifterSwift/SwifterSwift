// BidirectionalCollectionExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

final class BidirectionalCollectionExtensionsTests: XCTestCase {
    func testOffsetSubscript() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(arr[offset: 0], 1)
        XCTAssertEqual(arr[offset: 4], 5)
        XCTAssertEqual(arr[offset: -2], 4)
    }

    func testLastByKeyPath() {
        let array1 = [
            Person(name: "John", age: 30, location: Location(city: "Boston")),
            Person(name: "Jan", age: 22, location: nil),
            Person(name: "Roman", age: 30, location: Location(city: "Moscow"))
        ]

        let last30Age = array1.last(where: \.age, equals: 30)

        XCTAssertEqual(last30Age, array1.last)

        let missingPerson = array1.last(where: \.name, equals: "Tom")

        XCTAssertNil(missingPerson)
    }
}
