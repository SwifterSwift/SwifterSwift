//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


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
		return Double(M_PI) * self / 180.0
	}
	
	/// SwifterSwift: Floor of double value.
	public var floor: Double {
		return Foundation.floor(self)
	}
	
	/// SwifterSwift: Degree value of radian input.
	public var radiansToDegrees: Double {
		return self * 180 / Double(M_PI)
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
	public static func randomBetween(min: Double, max: Double) -> Double {
		let delta = max - min
		return min + Double(arc4random_uniform(UInt32(delta)))
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
