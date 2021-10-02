// BinaryIntegerExtensions.swift - Copyright 2021 SwifterSwift

#if canImport(Foundation)
import Foundation

// MARK: - Initializers

public extension BinaryInteger {
    /// SwifterSwift: Creates a `BinaryInteger` from a raw byte representaion.
    ///
    ///     var number = Int16([0xFF, 0b11111101])
    ///     print(number!)
    ///     // prints "-3"
    ///
    /// - Parameter bytes: An array of bytes representing the value of the integer.
    init?(_ bytes: [UInt8]) {
        // https://stackoverflow.com/a/43518567/9506784
        precondition(bytes.count <= MemoryLayout<Self>.size,
                     "Integer with a \(bytes.count) byte binary representation of '\(bytes.map({ String($0, radix: 2) }).joined(separator: " "))' overflows when stored into a \(MemoryLayout<Self>.size) byte '\(Self.self)'")
        var value: Self = 0
        for byte in bytes {
            value <<= 8
            value |= Self(byte)
        }
        self.init(exactly: value)
    }
}

#endif
