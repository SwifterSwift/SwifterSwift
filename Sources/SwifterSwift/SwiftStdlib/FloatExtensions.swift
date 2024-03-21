// FloatExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: - Properties

public extension Float {
    /// SwifterSwift: Int.
    var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Double.
    var double: Double {
        return Double(self)
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
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}
