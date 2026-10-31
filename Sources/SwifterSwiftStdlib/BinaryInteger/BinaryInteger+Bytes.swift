// BinaryInteger+Bytes.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger where Self: FixedWidthInteger {
    /// SwifterSwift: Returns the bytes of the integer's binary representation.
    ///
    /// The array always has one byte per 8 bits of the type's width, so leading zero bytes are kept, and negative
    /// values use two's complement. Big-endian order (most significant byte first) matches network byte order and the
    /// way the number is written; pass `bigEndian: false` for the least significant byte first.
    ///
    /// ```swift
    /// Int16(300).bytes()  // [0x01, 0x2C]
    /// Int16(300).bytes(bigEndian: false)  // [0x2C, 0x01]
    /// Int16(-2).bytes()  // [0xFF, 0xFE]
    /// UInt32(1).bytes()  // [0x00, 0x00, 0x00, 0x01]
    /// ```
    ///
    /// The result doesn't depend on the byte order of the platform. `init(bytes:bigEndian:)` reads the bytes back.
    ///
    /// - Parameter bigEndian: Whether the most significant byte comes first. The default is `true`.
    /// - Returns: The `bitWidth / 8` bytes of the integer, in the requested order.
    /// - Complexity: O(*n*), where *n* is the number of bytes in the type.
    func bytes(bigEndian: Bool = true) -> [UInt8] {
        let littleEndianBytes = (0..<(Self.bitWidth + 7) / 8).map { UInt8(truncatingIfNeeded: self >> ($0 * 8)) }
        return bigEndian ? littleEndianBytes.reversed() : littleEndianBytes
    }
}
