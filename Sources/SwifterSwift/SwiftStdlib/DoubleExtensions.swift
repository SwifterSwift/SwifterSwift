// DoubleExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: - Properties

public extension Double {
    /// SwifterSwift: Int.
    var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Float.
    var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    /// SwifterSwift: CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}
