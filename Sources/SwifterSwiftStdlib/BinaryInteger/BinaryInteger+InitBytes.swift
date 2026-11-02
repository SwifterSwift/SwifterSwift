// BinaryInteger+InitBytes.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger where Self: FixedWidthInteger {
    /// SwifterSwift: Creates an integer from the bytes of its binary representation.
    ///
    /// The bytes are read as a two's complement bit pattern, so `[0xFF]` makes `Int8(-1)` but `UInt8(255)`. When
    /// there are fewer bytes than the type holds, the missing high-order bytes are zero: `Int16(bytes: [0xFF])` is
    /// `255`, and an empty collection gives `0`. More bytes than the type holds return `nil`.
    ///
    /// ```swift
    /// Int16(bytes: [0x01, 0x2C])  // 300
    /// Int16(bytes: [0x2C, 0x01], bigEndian: false)  // 300
    /// Int16(bytes: [0xFF, 0xFE])  // -2
    /// Int8(bytes: [0x80])  // -128
    /// Int8(bytes: [0x01, 0x02])  // nil
    /// ```
    ///
    /// `bytes(bigEndian:)` produces the bytes this initializer reads.
    ///
    /// - Parameters:
    ///   - bytes: The bytes of the integer. Any collection of `UInt8` works, including `Data` and `ArraySlice`.
    ///   - bigEndian: Whether the most significant byte comes first. The default is `true`.
    /// - Complexity: O(*n*), where *n* is the number of bytes.
    init?(bytes: some Collection<UInt8>, bigEndian: Bool = true) {
        guard bytes.count <= (Self.bitWidth + 7) / 8 else { return nil }
        var value: Self = 0
        for byte in bigEndian ? Array(bytes) : bytes.reversed() {
            value = value << 8 | Self(truncatingIfNeeded: byte)
        }
        self = value
    }
}
