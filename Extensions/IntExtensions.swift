//
//  IntExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Int {
	/// Return absolute of integer value.
	public var abs: Int {
		return Swift.abs(self)
	}
	
	/// Return string with number and current locale currency
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		return formatter.string(from: self as NSNumber)!
	}
	
	/// Return radian value of degree input.
	public var degreesToRadians: Double {
		return Double(M_PI) * Double(self) / 180.0
	}
	
	/// Return array of digits of integer value.
	public var digits: [Int] {
		var digits: [Int] = []
		for char in String(self).characters {
			if let int = Int(String(char)) {
				digits.append(int)
			}
		}
		return digits
	}
	
	/// Returns number of digits of integer value.
	public var digitsCount: Int {
		return String(self).characters.count
	}
	
	/// Return greatest common divisor of integer value and n.
	public func gcd(of n: Int) -> Int {
		return n == 0 ? self : n.gcd(of: self % n)
	}
	
}

/// Return value of exponentiation.
infix operator **
public func ** (leftInt: Int, rightInt: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(Double(leftInt), Double(rightInt))
}

public extension Int {
	/// Checks if integer value is even.
	public var isEven: Bool {
		return (self % 2) == 0
	}
	
	/// Checks if integer value is odd.
	public var isOdd: Bool {
		return (self % 2) != 0
	}
	
	/// Return least common multiple of integer value and n.
	public func lcm(of n: Int) -> Int {
		return (self * n).abs / gcd(of: n)
	}
	
	/// Return degree value of radian input
	public var radiansToDegrees: Double {
		return Double(self) * 180 / Double(M_PI)
	}
	
	/// Return random integer value between two integer values.
	public static func randomBetween(min: Int, max: Int) -> Int {
		let delta = max - min
		return min + Int(arc4random_uniform(UInt32(delta)))
	}
	
	/// Return roman numeral from integer.
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
		guard romanValue.characters.count > 0 else {
			return nil
		}
		return romanValue
	}
	
	/// Return string of format (XXh XXm) from seconds Int
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
		
		if hours == 0 && mins != 0 {
			return "\(mins) min"
			
		} else if hours != 0 && mins == 0 {
			return "\(hours) h"
			
		} else {
			return "\(hours) h \(mins) m"
		}
	}
}

/// Return square root of value.
prefix operator √
public prefix func √ (int: Int) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(Double(int))
}

/// Return tuple of plus-minus operation.
infix operator ±
public func ± (leftInt: Int, rightInt: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return (leftInt + rightInt, leftInt - rightInt)
}

// Return tuple of plus-minus operation.
prefix operator ±
public prefix func ± (value: Int) -> (Int, Int) {
	// http://nshipster.com/swift-operators/
	return 0 ± value
}
