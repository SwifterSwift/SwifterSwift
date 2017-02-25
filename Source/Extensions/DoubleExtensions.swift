//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif


// MARK: - Properties
public extension Double {
	
	/// SwifterSwift: Absolute of double value.
	public var abs: Double {
		return Swift.abs(self)
	}
	
	/// SwifterSwift: String with number and current locale currency.
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}
	
	/// SwifterSwift: Ceil of double value.
	public var ceil: Double {
		return Foundation.ceil(self)
	}
	
	/// SwifterSwift: Radian value of degree input.
	public var degreesToRadians: Double {
		return Double.pi * self / 180.0
	}
	
	/// SwifterSwift: Floor of double value.
	public var floor: Double {
		return Foundation.floor(self)
	}
	
	/// SwifterSwift: Check if double is positive.
	public var isPositive: Bool {
		return self > 0
	}
	
	/// SwifterSwift: Check if double is negative.
	public var isNegative: Bool {
		return self < 0
	}
	
	/// SwifterSwift: Int.
	public var int: Int {
		return Int(self)
	}
	
	/// SwifterSwift: Float.
	public var float: Float {
		return Float(self)
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
	public var radiansToDegrees: Double {
		return self * 180 / Double.pi
	}
	
}


// MARK: - Methods
extension Double {
	
	/// SwifterSwift: Random double between two double values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random double between two double values.
	public static func random(between min: Double, and max: Double) -> Double {
		return random(inRange: min...max)
	}
	
	/// SwifterSwift: Random double in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public static func random(inRange range: ClosedRange<Double>) -> Double {
		let delta = range.upperBound - range.lowerBound
		return Double(arc4random()) / Double(UInt64(UINT32_MAX)) * delta + range.lowerBound
	}
	
}


// MARK: - Initializers
public extension Double {
	
	/// SwifterSwift: Created a random double between two double values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	public init(randomBetween min: Double, and max: Double) {
		self = Double.random(between: min, and: max)
	}
	
	/// SwifterSwift: Create a random double in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public init(randomInRange range: ClosedRange<Double>) {
		self = Double.random(inRange: range)
	}
	
}


// MARK: - Operators

infix operator **
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

prefix operator √
/// SwifterSwift: Square root of double.
///
/// - Parameter int: double value to find square root for
/// - Returns: square root of given double.
public prefix func √ (double: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(double)
}

infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: double number
///   - rhs: double number
/// - Returns: tuple of plus-minus operation (example: 2.5 ± 1.5 -> (4, 1)).
public func ± (lhs: Double, rhs: Double) -> (Double, Double) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}

prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: double number
/// - Returns: tuple of plus-minus operation (example: ± 2.5 -> (2.5, -2.5)).
public prefix func ± (double: Double) -> (Double, Double) {
	// http://nshipster.com/swift-operators/
	return 0 ± double
}
