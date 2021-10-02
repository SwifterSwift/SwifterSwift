// BinaryIntegerExtensionsTests.swift - Copyright 2021 SwifterSwift

@testable import SwifterSwift
import XCTest

final class BinaryIntegerExtensionsTests: XCTestCase {
    func testInitBytes() {
        let zero = Int8([0])
        assert(zero == 0)
        
        let negativeOne = Int16([0b1111_1111, 0b1111_1111])
        assert(negativeOne == -1)

        let fortyTwo = Int16([0, 0b0010_1010])
        assert(fortyTwo == 42)

        let uint64Max = UInt64([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF])
        assert(uint64Max == UInt64.max)
    }
}
