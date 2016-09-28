//
//  FloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

public extension Float {
	/// Return absolute of double value.
	public var abs: Float {
		return Swift.abs(self)
	}
	
	/// Return string with number and current locale currency
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}
	
	/// Return ceil of float value.
	public var ceil: Float {
		return Foundation.ceil(self)
	}
	
	/// Return radian value of degree input.
	public var degreesToRadians: Float {
		return Float(M_PI) * self / 180.0
	}
	
	/// Return random float value between two float values.
	public static func randomBetween(min: Float, max: Float) -> Float {
		let delta = max - min
		return min + Float(arc4random_uniform(UInt32(delta)))
	}
}


/// Return value of exponentiation.
infix operator **
public func ** (left: Float, right: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return pow(left, right)
}

public extension Float {
	/// Return floor of double value.
	public var floor: Float {
		return Foundation.floor(self)
	}
	
	/// Return degree value of radian input.
	public var radiansToDegrees: Float {
		return self * 180 / Float(M_PI)
	}
}

/// Return tuple of plus-minus operation.
infix operator ±
public func ± (leftFloat: Float, rightFloat: Float) -> (Float, Float) {
	// http://nshipster.com/swift-operators/
	return (leftFloat + rightFloat, leftFloat - rightFloat)
}

// Return tuple of plus-minus operation.
prefix operator ±
public prefix func ± (float: Float) -> (Float, Float) {
	// http://nshipster.com/swift-operators/
	return 0 ± float
}

/// Return square root of value.
prefix operator √
public prefix func √ (float: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return sqrt(float)
}
