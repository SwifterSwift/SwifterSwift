//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

public extension Double {
	/// Return absolute of double value.
	public var abs: Double {
		return Swift.abs(self)
	}
	
	/// Return string with number and current locale currency
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}
	
	/// Return ceil of double value.
	public var ceil: Double {
		return Foundation.ceil(self)
	}
	
	/// Return radian value of degree input.
	public var degreesToRadians: Double {
		return Double(M_PI) * self / 180.0
	}
	
	/// Return random double value between two double values.
	public static func randomBetween(min: Double, max: Double) -> Double {
		let delta = max - min
		return min + Double(arc4random_uniform(UInt32(delta)))
	}
}

/// Return value of exponentiation.
infix operator **
public func ** (leftDouble: Double, rightDouble: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(leftDouble, rightDouble)
}

public extension Double {
	/// Return floor of double value.
	public var floor: Double {
		return Foundation.floor(self)
	}
	
	/// Return degree value of radian input.
	public var radiansToDegrees: Double {
		return self * 180 / Double(M_PI)
	}
}

/// Return tuple of plus-minus operation.
infix operator ±
public func ± (leftDouble: Double, rightDouble: Double) -> (Double, Double) {
	// http://nshipster.com/swift-operators/
	return (leftDouble + rightDouble, leftDouble - rightDouble)
}

// Return tuple of plus-minus operation.
prefix operator ±
public prefix func ± (double: Double) -> (Double, Double) {
	// http://nshipster.com/swift-operators/
	return 0 ± double
}

/// Return square root of value.
prefix operator √
public prefix func √ (double: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(double)
}
