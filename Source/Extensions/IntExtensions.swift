//
//  IntExtensions.swift
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
public extension Int {
	
	/// SwifterSwift: Absolute value of integer.
	public var abs: Int {
		return Swift.abs(self)
	}
	
	/// SwifterSwift: String with number and current locale currency.
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}
	
	/// SwifterSwift: Radian value of degree input.
	public var degreesToRadians: Double {
		return Double.pi * Double(self) / 180.0
	}
	
	/// SwifterSwift: Array of digits of integer value.
	public var digits: [Int] {
		var digits: [Int] = []
		for char in String(self).characters {
			if let int = Int(String(char)) {
				digits.append(int)
			}
		}
		return digits
	}
	
	/// SwifterSwift: Number of digits of integer value.
	public var digitsCount: Int {
		return String(self).characters.count
	}
	
	/// SwifterSwift: Check if integer is even.
	public var isEven: Bool {
		return (self % 2) == 0
	}
	
	/// SwifterSwift: Check if integer is odd.
	public var isOdd: Bool {
		return (self % 2) != 0
	}
	
	/// SwifterSwift: Check if integer is positive.
	public var isPositive: Bool {
		return self > 0
	}
	
	/// SwifterSwift: Check if integer is negative.
	public var isNegative: Bool {
		return self < 0
	}
	
	/// SwifterSwift: Double.
	public var double: Double {
		return Double(self)
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
	
	/// SwifterSwift: Degree value of radian input
	public var radiansToDegrees: Double {
		return Double(self) * 180 / Double.pi
	}
	
	/// SwifterSwift: Roman numeral string from integer (if applicable).
	public var romanNumeral: String? {
		// https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
		guard self > 0 else { // there is no roman numerals for 0 or negative numbers
			return nil
		}
		let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
		let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
		
		var romanValue = ""
		var startingValue = self
		
		for (index, romanChar) in romanValues.enumerated() {
			let arabicValue = arabicValues[index]
			let div = startingValue / arabicValue
			if (div > 0) {
				for _ in 0..<div {
					romanValue += romanChar
				}
				startingValue -= arabicValue * div
			}
		}
		return romanValue
	}
	
	/// SwifterSwift: String of format (XXh XXm) from seconds Int.
	public var timeString: String {
		guard self > 0 else {
			return "0 sec"
		}
		if self < 60 {
			return "\(self) sec"
		}
		if self < 3600 {
			return "\(self / 60) min"
		}
		let hours = self / 3600
		let mins = (self % 3600) / 60
		
		if hours != 0 && mins == 0 {
			return "\(hours)h"
		}
		return "\(hours)h \(mins)m"
	}
	
	/// SwifterSwift: String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
	public var kFormatted: String {
		var sign: String {
			return self >= 0 ? "" : "-"
		}
		let abs = self.abs
		if abs == 0 {
			return "0k"
		} else if abs >= 0 && abs < 1000 {
			return "0k"
		} else if abs >= 1000 && abs < 1000000 {
			return String(format: "\(sign)%ik", abs / 1000)
		}
		return String(format: "\(sign)%ikk", abs / 100000)
	}
	
}


// MARK: - Methods
public extension Int {
	
	/// SwifterSwift: Greatest common divisor of integer value and n.
	///
	/// - Parameter n: integer value to find gcd with.
	/// - Returns: greatest common divisor of self and n.
	public func gcd(of n: Int) -> Int {
		return n == 0 ? self : n.gcd(of: self % n)
	}
	
	/// SwifterSwift: Least common multiple of integer and n.
	///
	/// - Parameter n: integer value to find lcm with.
	/// - Returns: least common multiple of self and n.
	public func lcm(of n: Int) -> Int {
		return (self * n).abs / gcd(of: n)
	}
	
	/// SwifterSwift: Random integer between two integer values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random double between two double values.
	public static func random(between min: Int, and max: Int) -> Int {
		return random(inRange: min...max)
	}
	
	/// SwifterSwift: Random integer in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public static func random(inRange range: ClosedRange<Int>) -> Int {
		let delta = UInt32(range.upperBound - range.lowerBound + 1)
		return range.lowerBound + Int(arc4random_uniform(delta))
	}
	
}


// MARK: - Initializers
public extension Int {
	
	/// SwifterSwift: Created a random integer between two integer values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	public init(randomBetween min: Int, and max: Int) {
		self = Int.random(between: min, and: max)
	}
	
	/// SwifterSwift: Create a random integer in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	public init(randomInRange range: ClosedRange<Int>) {
		self = Int.random(inRange: range)
	}
	
}


// MARK: - Operators

infix operator **
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ** 3 = 8).
public func ** (lhs: Int, rhs: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(Double(lhs), Double(rhs))
}

prefix operator √
/// SwifterSwift: Square root of integer.
///
/// - Parameter int: integer value to find square root for
/// - Returns: square root of given integer.
public prefix func √ (int: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(Double(int))
}

infix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: integer number
///   - rhs: integer number
/// - Returns: tuple of plus-minus operation (example: 2 ± 3 -> (5, -1)).
public func ± (lhs: Int, rhs: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return (lhs + rhs, lhs - rhs)
}

prefix operator ±
/// SwifterSwift: Tuple of plus-minus operation.
///
/// - Parameter int: integer number
/// - Returns: tuple of plus-minus operation (example: ± 2 -> (2, -2)).
public prefix func ± (int: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return 0 ± int
}
