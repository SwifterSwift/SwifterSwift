// BinaryInteger+BytesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerBytesTests {
    @Test
    func returnsBigEndianBytesByDefault() {
        #expect(Int16(300).bytes() == [0x01, 0x2C])
        #expect(UInt32(0x0102_0304).bytes() == [0x01, 0x02, 0x03, 0x04])
        #expect(Int8(42).bytes() == [0x2A])
    }

    @Test
    func returnsLittleEndianBytesOnRequest() {
        #expect(Int16(300).bytes(bigEndian: false) == [0x2C, 0x01])
        #expect(UInt32(0x0102_0304).bytes(bigEndian: false) == [0x04, 0x03, 0x02, 0x01])
    }

    @Test
    func keepsLeadingZeroBytes() {
        #expect(Int32.zero.bytes() == [0, 0, 0, 0])
        #expect(UInt64(1).bytes() == [0, 0, 0, 0, 0, 0, 0, 1])
    }

    @Test
    func usesTwosComplementForNegativeValues() {
        #expect(Int8(-1).bytes() == [0xFF])
        #expect(Int16(-2).bytes() == [0xFF, 0xFE])
        #expect(Int8.min.bytes() == [0x80])
        #expect(Int64.min.bytes() == [0x80, 0, 0, 0, 0, 0, 0, 0])
        #expect(Int64.min.bytes(bigEndian: false) == [0, 0, 0, 0, 0, 0, 0, 0x80])
    }

    @Test
    func handlesExtremeValues() {
        #expect(UInt64.max.bytes() == Array(repeating: 0xFF, count: 8))
        #expect(Int64.max.bytes() == [0x7F] + Array(repeating: 0xFF, count: 7))
        #expect(UInt8.max.bytes() == [0xFF])
    }

    @Test
    func returnsOneBytePerEightBitsOfTheType() {
        #expect(Int8(0).bytes().count == 1)
        #expect(UInt16(0).bytes().count == 2)
        #expect(Int32(0).bytes().count == 4)
        #expect(UInt64(0).bytes().count == 8)
        #expect(Int(0).bytes().count == Int.bitWidth / 8)
    }

    @Test(arguments: [Int64.min, -1_000_000, -1, 0, 1, 255, 256, 1_000_000_007, Int64.max])
    func roundTripsThroughTheInitializer(value: Int64) {
        #expect(Int64(bytes: value.bytes()) == value)
        #expect(Int64(bytes: value.bytes(bigEndian: false), bigEndian: false) == value)
        #expect(value.bytes(bigEndian: false) == value.bytes().reversed())
    }
}
