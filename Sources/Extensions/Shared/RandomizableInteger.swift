//
//  RandomizableInteger.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 13/04/2018.
//  Copyright © 2018 SwifterSwift
//

/// An integer from which we can generate random numbers.
public protocol RandomizableInteger: FixedWidthInteger {
    /// SwifterSwift: Generate a random integer within a given range.
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound of the integer range.
    ///   - upperBound: The upper bound of the integer range.
    /// - Returns: An integer between `lowerBound` and `upperBound` (exclusive).
    static func random(lowerBound: Self, upperBound: Self) -> Self
}

/// A signed integer that has an unsigned integer counterpart
public protocol SignedRandomizableInteger: RandomizableInteger, SignedInteger {

    /// The `UnsignedInteger` counterpart with equal bit width
    associatedtype Unsigned: UnsignedRandomizableInteger

}

/// An unsigned integer that has a signed integer counterpart
public protocol UnsignedRandomizableInteger: RandomizableInteger, UnsignedInteger {

    /// The `SignedInteger` counterpart with equal bit width
    associatedtype Signed: SignedRandomizableInteger

}

// MARK: - Random functions

// The randomization functions are adapted from @jstn's solution:
// https://stackoverflow.com/questions/24007129/how-does-one-generate-a-random-number-in-apples-swift-language/25129039#25129039

public extension UnsignedRandomizableInteger {
    /// SwifterSwift: Generate a random integer within a given range.
    ///
    ///   This version is able to handle `UInt64`,
    ///   which would not be possible using `BinaryInteger.random(lowerBound:upperBound:)`
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound of the integer range. Defaults to 0.
    ///   - upperBound: The upper bound of the integer range.
    /// - Returns: An integer between `lowerBound` and `upperBound` (exclusive).
    /// - Complexity:
    ///   This could theoretically loop forever but each retry has p > 0.5 (worst case, usually far better).
    public static func random(lowerBound: Self = 0, upperBound: Self) -> Self {
        // Static asserts are not yet available in Swift
        assert(Self.bitWidth == Signed.bitWidth)
        assert(lowerBound < upperBound)

        var mod: Self
        let diff = upperBound - lowerBound
        var rand: Self = arc4random()

        if diff > Self(Signed.max) {
            mod = 1 + ~diff
        } else {
            mod = ((max - (diff * 2)) + 1) % diff
        }

        while rand < mod {
            rand = arc4random()
        }

        return (rand % diff) + lowerBound
    }
}

public extension SignedRandomizableInteger {
    /// SwifterSwift: Generate a random integer within a given range.
    ///
    ///   This version is able to handle `Int64`, as well as finding a random number in the range `Self.min..<Self.max`,
    ///   which would not be possible using `BinaryInteger.random(lowerBound:upperBound:)` due to overflow
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound of the integer range. Defaults to 0.
    ///   - upperBound: The upper bound of the integer range.
    /// - Returns: An integer between `lowerBound` and `upperBound` (exclusive).
    public static func random(lowerBound: Self = 0, upperBound: Self) -> Self {
        // Static asserts are not yet available in Swift
        assert(Self.bitWidth == Unsigned.bitWidth)
        assert(lowerBound < upperBound)

        let (sub, overflow) = upperBound.subtractingReportingOverflow(lowerBound)
        let diff = overflow ? Unsigned.max - Unsigned(~sub) : Unsigned(sub)
        let rand = Unsigned.random(upperBound: diff)

        if rand > Unsigned(Self.max) {
            return Self(rand - (Unsigned(~lowerBound) + 1))
        } else {
            return Self(rand) + lowerBound
        }
    }
}

// MARK: -
// MARK: SignedRandomizableInteger types

extension Int: SignedRandomizableInteger {
    public typealias Unsigned = UInt
}

extension Int8: SignedRandomizableInteger {
    public typealias Unsigned = UInt8
}

extension Int16: SignedRandomizableInteger {
    public typealias Unsigned = UInt16
}

extension Int32: SignedRandomizableInteger {
    public typealias Unsigned = UInt32
}

extension Int64: SignedRandomizableInteger {
    public typealias Unsigned = UInt64
}

// MARK: UnsignedRandomizableInteger types

extension UInt: UnsignedRandomizableInteger {
    public typealias Signed = Int
}

extension UInt8: UnsignedRandomizableInteger {
    public typealias Signed = Int8
}

extension UInt16: UnsignedRandomizableInteger {
    public typealias Signed = Int16
}

extension UInt32: UnsignedRandomizableInteger {
    public typealias Signed = Int32
}

extension UInt64: UnsignedRandomizableInteger {
    public typealias Signed = Int64
}

// MARK: - Private functions

private func arc4random<T: ExpressibleByIntegerLiteral>() -> T {
    var rand: T = 0
    arc4random_buf(&rand, MemoryLayout<T>.size)
    return rand
}
