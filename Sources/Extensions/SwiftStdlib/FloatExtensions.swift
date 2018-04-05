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
	public var int: Int {
		return Int(self)
	}

	/// SwifterSwift: Double.
	public var double: Double {
		return Double(self)
	}

	#if canImport(CoreGraphics)
	/// SwifterSwift: CGFloat.
	public var cgFloat: CGFloat {
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
public func ** (lhs: Float, rhs: Float) -> Float {
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
