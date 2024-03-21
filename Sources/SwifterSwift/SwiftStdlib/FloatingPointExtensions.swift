// FloatingPointExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties

public extension FloatingPoint {
    /// SwifterSwift: Absolute value of number.
    var abs: Self {
        return Swift.abs(self)
    }

    /// SwifterSwift: Check if number is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// SwifterSwift: Check if number is negative.
    var isNegative: Bool {
        return self < 0
    }

    #if canImport(Foundation)
    /// SwifterSwift: Ceil of number.
    var ceil: Self {
        return Foundation.ceil(self)
    }
    #endif

    /// SwifterSwift: Radian value of degree input.
    var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }

    #if canImport(Foundation)
    /// SwifterSwift: Floor of number.
    var floor: Self {
        return Foundation.floor(self)
    }
    #endif

    /// SwifterSwift: Degree value of radian input.
    var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}

// MARK: - Operators

// swiftlint:disable identifier_name
infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: number.
///   - rhs: number.
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
public func ± <T: FloatingPoint>(lhs: T, rhs: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return (lhs + rhs, lhs - rhs)
}

// swiftlint:enable identifier_name

// swiftlint:disable identifier_name
prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: number.
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ± <T: FloatingPoint>(number: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return 0 ± number
}

// swiftlint:enable identifier_name

// swiftlint:disable identifier_name
prefix operator √
/// SwifterSwift: Square root of float.
///
/// - Parameter float: float value to find square root for.
/// - Returns: square root of given float.
public prefix func √ <T>(float: T) -> T where T: FloatingPoint {
    // http://nshipster.com/swift-operators/
    return sqrt(float)
}

// swiftlint:enable identifier_name
