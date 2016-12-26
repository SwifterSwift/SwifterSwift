//
//  FloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Properties
public extension Float {

	/// SwifterSwift: Absolute of float value.
	public var abs: Float {
		return Swift.abs(self)
	}

	/// SwifterSwift: String with number and current locale currency.
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}

	/// SwifterSwift: Ceil of float value.
	public var ceil: Float {
		return Foundation.ceil(self)
	}

	/// SwifterSwift: Radian value of degree input.
	public var degreesToRadians: Float {
		return Float(M_PI) * self / 180.0
	}

	/// SwifterSwift: Floor of float value.
	public var floor: Float {
		return Foundation.floor(self)
	}

	/// SwifterSwift: Degree value of radian input.
	public var radiansToDegrees: Float {
		return self * 180 / Float(M_PI)
	}

}


// MARK: - Methods
extension Float {

	/// SwifterSwift: Random float between two float values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random float between two Float values.
	public static func randomBetween(min: Float, max: Float) -> Float {
		let delta = max - min
		return min + Float(arc4random_uniform(UInt32(delta)))
	}

}


// MARK: - Operators

infix operator **
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

prefix operator √
/// SwifterSwift: Square root of float.
///
/// - Parameter int: float value to find square root for
/// - Returns: square root of given float.
public prefix func √ (Float: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return sqrt(Float)
}

infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: float number
///   - rhs: float number
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
public func ± (lhs: Float, rhs: Float) -> (Float, Float) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}

prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: float number
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ± (Float: Float) -> (Float, Float) {
	// http://nshipster.com/swift-operators/
	return 0 ± Float
}
