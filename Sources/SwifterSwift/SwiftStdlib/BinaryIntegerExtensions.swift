// BinaryIntegerExtensions.swift - Copyright 2023 SwifterSwift

// MARK: - Properties

public extension BinaryInteger {
    /// SwifterSwift: The raw bytes of the integer.
    ///
    ///     var number = Int16(-128)
    ///     print(number.bytes)
    ///     // prints "[255, 128]"
    ///
    var bytes: [UInt8] {
        var result = [UInt8]()
        result.reserveCapacity(MemoryLayout<Self>.size)
        var value = self
        for _ in 0..<MemoryLayout<Self>.size {
            result.append(UInt8(truncatingIfNeeded: value))
            value >>= 8
        }
        return result.reversed()
    }
}

// MARK: - Initializers

public extension BinaryInteger {
    /// SwifterSwift: Creates a `BinaryInteger` from a raw byte representation.
    ///
    ///     var number = Int16(bytes: [0xFF, 0b1111_1101])
    ///     print(number!)
    ///     // prints "-3"
    ///
    /// - Parameter bytes: An array of bytes representing the value of the integer.
    init?(bytes: [UInt8]) {
        // https://stackoverflow.com/a/43518567/9506784
        precondition(bytes.count <= MemoryLayout<Self>.size,
                     "Integer with a \(bytes.count) byte binary representation of '\(bytes.map { String($0, radix: 2) }.joined(separator: " "))' overflows when stored into a \(MemoryLayout<Self>.size) byte '\(Self.self)'")
        var value: Self = 0
        for byte in bytes {
            value <<= 8
            value |= Self(byte)
        }
        self.init(exactly: value)
    }
}
