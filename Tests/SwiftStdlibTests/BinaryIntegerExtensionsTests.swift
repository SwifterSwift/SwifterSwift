// BinaryIntegerExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

final class BinaryIntegerExtensionsTests: XCTestCase {
    func testBytes() {
        let zero = Int32.zero.bytes
        XCTAssertEqual(zero, Array(repeating: 0, count: 4))

        let negativeOne = Int8(-1).bytes
        XCTAssertEqual(negativeOne, [0xFF])

        let threeHundred = Int16(300).bytes
        XCTAssertEqual(threeHundred, [1, 0b0010_1100])

        let uint64Max = UInt64.max.bytes
        XCTAssertEqual(uint64Max, Array(repeating: 0xFF, count: 8))
    }

    func testInitBytes() {
        let zero = Int8(bytes: [0])
        XCTAssertEqual(zero, 0)

        let negativeOne = Int16(bytes: [0b1111_1111, 0b1111_1111])
        XCTAssertEqual(negativeOne, -1)

        let fortyTwo = Int16(bytes: [0, 0b0010_1010])
        XCTAssertEqual(fortyTwo, 42)

        let uint64Max = UInt64(bytes: Array(repeating: 0xFF, count: 8))
        XCTAssertEqual(uint64Max, UInt64.max)
    }
}
