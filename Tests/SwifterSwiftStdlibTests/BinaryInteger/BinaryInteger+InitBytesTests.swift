// BinaryInteger+InitBytesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerInitBytesTests {
    @Test
    func readsBigEndianBytesByDefault() {
        #expect(Int16(bytes: [0x01, 0x2C]) == 300)
        #expect(UInt32(bytes: [0x01, 0x02, 0x03, 0x04]) == 0x0102_0304)
        #expect(Int16(bytes: [0, 0b0010_1010]) == 42)
    }

    @Test
    func readsLittleEndianBytesOnRequest() {
        #expect(Int16(bytes: [0x2C, 0x01], bigEndian: false) == 300)
        #expect(UInt32(bytes: [0x04, 0x03, 0x02, 0x01], bigEndian: false) == 0x0102_0304)
    }

    @Test
    func readsTwosComplementForSignedTypes() {
        #expect(Int8(bytes: [0x80]) == -128)
        #expect(Int8(bytes: [0xFF]) == -1)
        #expect(Int16(bytes: [0xFF, 0xFF]) == -1)
        #expect(Int16(bytes: [0xFF, 0xFD]) == -3)
        #expect(Int64(bytes: [0x80, 0, 0, 0, 0, 0, 0, 0]) == .min)
    }

    @Test
    func readsTheSameBitsAsUnsignedForUnsignedTypes() {
        #expect(UInt8(bytes: [0x80]) == 128)
        #expect(UInt8(bytes: [0xFF]) == 255)
        #expect(UInt64(bytes: Array(repeating: 0xFF, count: 8)) == .max)
    }

    @Test
    func fillsMissingHighOrderBytesWithZeros() {
        #expect(Int16(bytes: [0xFF]) == 255)
        #expect(Int16(bytes: [0xFF], bigEndian: false) == 255)
        #expect(UInt32(bytes: [0x01, 0x00]) == 256)
        #expect(UInt32(bytes: [0x01, 0x00], bigEndian: false) == 1)
    }

    @Test
    func returnsZeroForNoBytes() {
        #expect(Int(bytes: []) == 0)
        #expect(UInt8(bytes: [], bigEndian: false) == 0)
    }

    @Test
    func returnsNilForTooManyBytes() {
        #expect(Int8(bytes: [0x01, 0x02]) == nil)
        #expect(Int16(bytes: [0, 0, 1]) == nil)
        #expect(UInt64(bytes: Array(repeating: 0, count: 9)) == nil)
        #expect(Int32(bytes: Array(repeating: 0xFF, count: 100), bigEndian: false) == nil)
    }

    @Test
    func acceptsAnyCollectionOfBytes() {
        let bytes: [UInt8] = [0xAA, 0x01, 0x2C, 0xBB]
        #expect(Int16(bytes: bytes[1...2]) == 300)
        #expect(Int16(bytes: bytes[1...2].reversed(), bigEndian: false) == 300)
        #expect(Int16(bytes: Set([UInt8(0x2C)])) == 0x2C)
    }

    @Test
    func roundTripsEveryByteValue() {
        for value in Int8.min...Int8.max {
            #expect(Int8(bytes: value.bytes()) == value)
        }
        for value in UInt8.min...UInt8.max {
            #expect(UInt8(bytes: [value]) == value)
        }
    }
}
