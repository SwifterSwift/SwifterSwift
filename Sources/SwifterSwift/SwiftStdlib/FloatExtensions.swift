//
//  FloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics
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

#if canImport(Foundation) && !os(Linux)

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

#endif

#if canImport(Foundation) && !os(Linux)

prefix operator √
/// SwifterSwift: Square root of float.
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
// swiftlint:disable:next identifier_name
public prefix func √ (float: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return sqrt(float)
}

#endif
