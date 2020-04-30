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
    ///The float type takes 4 bytes and returns the corresponding 4 bytes
    var bitPatterns: [UInt8] {
        return [3, 2, 1, 0].map { UInt8((bitPattern >> (8 * $0)) & 0xff)}
    }
    ///Four bytes to float data
    init(bitPatterns: [UInt8]) {
        if bitPatterns.count != 4 {
            self =  0.0
        } else {
            let sum = [0, 1, 2, 3].map { (UInt32(bitPatterns[$0]) << (24-$0*8))}.reduce(into: 0, +=)
            self = .init(bitPattern: sum)
        }
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

// swiftlint:disable identifier_name
prefix operator √
/// SwifterSwift: Square root of float.
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
public prefix func √ (float: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return sqrt(float)
}
// swiftlint:enable identifier_name
