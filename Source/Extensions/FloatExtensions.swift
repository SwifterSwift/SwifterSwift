//
//  FloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif


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
		return Float.pi * self / 180.0
	}
	
	/// SwifterSwift: Floor of float value.
	public var floor: Float {
		return Foundation.floor(self)
	}
	
	/// SwifterSwift: Check if float is positive.
	public var isPositive: Bool {
		return self > 0
	}
	
	/// SwifterSwift: Check if float is negative.
	public var isNegative: Bool {
		return self < 0
	}
	
	/// SwifterSwift: Int.
	public var int: Int {
		return Int(self)
	}
	
	/// SwifterSwift: Double.
	public var double: Double {
		return Double(self)
	}
	
	/// SwifterSwift: CGFloat.
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
	
	/// SwifterSwift: String.
	public var string: String {
		return String(self)
	}
	
	/// SwifterSwift: Degree value of radian input.
	public var radiansToDegrees: Float {
		return self * 180 / Float.pi
	}
	
}


// MARK: - Methods
extension Float {
	
	/// SwifterSwift: Random float between two float values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random double between two double values.
	public static func random(between min: Float, and max: Float) -> Float {
		return random(inRange: min...max)
	}
	
	/// SwifterSwift: Random float in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public static func random(inRange range: ClosedRange<Float>) -> Float {
		let delta = range.upperBound - range.lowerBound
		return Float(arc4random()) / Float(UInt64(UINT32_MAX)) * delta + range.lowerBound
	}
	
}


// MARK: - Initializers
public extension Float {
	
	/// SwifterSwift: Created a random float between two float values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	public init(randomBetween min: Float, and max: Float) {
		self = Float.random(between: min, and: max)
	}
	
	/// SwifterSwift: Create a random float in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public init(randomInRange range: ClosedRange<Float>) {
		self = Float.random(inRange: range)
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
