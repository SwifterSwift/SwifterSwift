// BinaryIntegerExtensionsTests.swift - Copyright 2021 SwifterSwift

@testable import SwifterSwift
import XCTest

final class BinaryIntegerExtensionsTests: XCTestCase {
    func testBytes() {
        let zero = Int32.zero.bytes
        assert(zero == Array(repeating: 0, count: 32 / 8))

        let negativeOne = Int8(-1).bytes
        assert(negativeOne == [0xFF])

        let threeHundred = Int16(300).bytes
        assert(threeHundred == [1, 0b0010_1100])

        let uint64Max = UInt64.max.bytes
        assert(uint64Max == Array(repeating: 0xFF, count: 64 / 8))
    }

    func testInitBytes() {
        let zero = Int8([0])
        assert(zero == 0)
        
        let negativeOne = Int16([0b1111_1111, 0b1111_1111])
        assert(negativeOne == -1)

        let fortyTwo = Int16([0, 0b0010_1010])
        assert(fortyTwo == 42)

        let uint64Max = UInt64(Array(repeating: 0xFF, count: 64 / 8))
        assert(uint64Max == UInt64.max)
    }
}
